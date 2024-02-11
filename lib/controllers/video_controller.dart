

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constant.dart';
import 'package:tiktok_clone/models/video.dart';

class VideoController extends GetxController{

  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();

    _videoList.bindStream(firestore.collection('videos')
    .snapshots().map((QuerySnapshot query){
      List<Video> returnVal = [];
      for (var element in query.docs) {
          returnVal.add(Video.fromSnap(element));
       }
       return returnVal;
    }));
  }


   // Like function

  //  likeVideo(String id)async{
  //   try{
  //     DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
  //   var uid = authController.user.uid;
  //   if ((doc.data()! as dynamic)['likes'].contains(uid)) {
  //       // ALREADY LIKED = UNLIKE
  //     await firestore.collection('videos').doc(id).update({
  //       'likes' : FieldValue.arrayRemove([uid]),
  //     });
  //   }else{
  //     // NOT LIKED YET = LIKE 
  //     await firestore.collection('videos').doc(id).update({
  //       'likes' : FieldValue.arrayUnion([uid]),
  //     });
  //   }
  //   }catch(e){
  //     Get.snackbar('Error in Adding Likes', e.toString());
  //       // DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
  //       // print((doc.data()! as dynamic)['likes']);
  //   }
  // }

   likeVideo(String id)async{
    try{
      DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user.uid;
    if ((doc.data() as dynamic)['likes'].contains(uid) ) {
        // ALREADY LIKED = UNLIKE
      await firestore.collection('videos').doc(id).update({
        'likes' : FieldValue.arrayRemove([uid]),
      });
    }else{
      // NOT LIKED YET = LIKE 
      await firestore.collection('videos').doc(id).update({
        'likes' : FieldValue.arrayUnion([uid]),
      });
    }
    }catch(e){
      Get.snackbar('Error in Adding Likes', e.toString());
        print(id);
        DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
      
      
        // print((doc.data() as dynamic)['']);
    }
  }

  // Gpt conditions

//   likeVideo(String id) async {
//   try {
//     DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    
//     var uid = authController.user.uid;

//     // Check if the document exists and 'likes' field is not null
//     if (doc.exists && doc.data() != null && (doc.data()! as dynamic)['likes'] != null) {
//       if ((doc.data()! as dynamic)['likes'].contains(uid)) {
//         // ALREADY LIKED = UNLIKE
//         await firestore.collection('videos').doc(id).update({
//           'likes': FieldValue.arrayRemove([uid]),
//         });
//       } else {
//         // NOT LIKED YET = LIKE
//         await firestore.collection('videos').doc(id).update({
//           'likes': FieldValue.arrayUnion([uid]),
//         });
//       }
//     }
//     else if(doc.exists ){
//       debugPrint('Doc Exist');
//     }
    
//     //  else {
//     //   // Handle the case where the document or 'likes' field is null
//     //   print('Document or likes field is null for id: $id');
//     // }
//   } catch (e) {
//       DocumentSnapshot doc = await firestore.collection('videos').doc(id).get(); 
//     Get.snackbar('Error in Adding Likes', e.toString());
//     debugPrint('ERROR $doc');
//   }
// }

}