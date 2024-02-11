
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constant.dart';
import 'package:tiktok_clone/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController{

        // To compress video using package
       _compressVideo(String videoPath) async {
          final compressedVideo =  await VideoCompress.compressVideo(
          videoPath ,
          quality: VideoQuality.MediumQuality);
          return compressedVideo!.file;
      }

        // upload video to storage
    Future<String>  _uploadVideoToStorage(String id ,String videoPath)async{
    
                                                // .folder.video(id()
      Reference ref = firebaseStorage.ref().child('videos').child(id);

      UploadTask uploadTask =   ref.putFile(await _compressVideo(videoPath));
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
     }
        // To get thumbnail
    _getThumbnail(String videoPath) async{

      final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
      return thumbnail;
    }
     
    // To upload thumbnail (image) of the video
    Future<String> _uploadImageToStorage(String id ,String videoPath )async{
      
      Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
      UploadTask uploadTask =   ref.putFile(await _getThumbnail(videoPath));
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      return downloadUrl;
    }

 
      // upload video to db
    uploadVideo(String songName , String caption , String videoPath)async{
    try{
      String uid =  firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc = await firestore.collection('user').doc(uid).get();
          // get id
    var allDocs = await firestore.collection('videos').get();
    var len = allDocs.docs.length;
    String videoUrl = await _uploadVideoToStorage("Video $len" , videoPath);
    String  thumbnail = await _uploadImageToStorage("Video $len" , videoPath);
    Video video =  Video(
      username: (userDoc.data()! as Map<String , dynamic>)['name'], 
      uid: uid, 
      id: "video $len", 
      likes: [], 
      commentCount: 0, 
      shareCount: 0, 
      songName: songName, 
      caption: caption, 
      videoUrl: videoUrl, 
      thumbnail: thumbnail, 
      profilePicture: (userDoc.data()! as Map<String , dynamic>)['profilePicture']);

          await firestore.collection('videos').doc("Video $len").set(video.toJson());
          Get.back();

    }catch(e){
        Get.snackbar('Error Uploading Video', e.toString());
    }


  }
    
}