import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constant.dart';
import 'package:tiktok_clone/models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);

  List<Comment> get comments => _comments.value;

  String _postId = '';

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  // Get Comments method
  getComment() async {
    _comments.bindStream(firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<Comment> returnVal = [];
      for (var element in snapshot.docs) {
        returnVal.add(Comment.fromSnap(element));
      }

      return returnVal;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user.uid)
            .get();
        var allDocs = await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        var len = allDocs.docs.length;

        Comment comment = Comment(
            username: (userDoc.data()! as dynamic)['name'],
            comment: commentText.trim(),
            likes: [],
            datePublish: DateTime.now(),
            profilePicture: (userDoc.data()! as dynamic)['profilePicture'],
            uid: authController.user.uid,
            id: 'Comment $len');
        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(comment.toJson());

        DocumentSnapshot doc =
            await firestore.collection('videos').doc(_postId).get();
        firestore.collection('videos').doc(_postId).update(
            {'CommentCount': (doc.data()! as dynamic)['commentCount'] + 1});
      }
    } catch (e) {
      Get.snackbar('Error while commenting', e.toString());
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
          'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
