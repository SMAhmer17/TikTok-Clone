import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constant.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List<String> thumbnails = [];

    var myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (int i = 0; i < myVideos.docs.length; i++) {
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePicture = userData['profilePicture'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFolowing = false;
    for (var item in myVideos.docs) {
      likes == (item.data()['likes'] as List).length;
    }
    // follower document
    var followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .get();

    // following document
    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();

    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFolowing = true;
      } else {
        isFolowing = false;
      }
    });

    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFolowing,
      'likes': likes.toString(),
      'profilePicture': profilePicture,
      'name': name,
      'thumbnails': thumbnails
    };
    update();
  }

  followUser() async {
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .get();


        if(!doc.exists){
          
          // followers
          await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .set({});
       
          // following

          await firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('followers')
        .doc(_uid.value)
        .set({});

        _user.value.update('followers', (value) => (int.parse(value + 1).toString()) );
        
        }else{
          
          // followers
          await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user.uid)
        .delete();
       
          // following

          await firestore
        .collection('users')
        .doc(authController.user.uid)
        .collection('followers')
        .doc(_uid.value)
        .delete();

        _user.value.update('followers', (value) => (int.parse(value - 1).toString()) );
      

        }

          _user.value.update('isFollowing', (value) => !value );
          update();
       

  }
}
