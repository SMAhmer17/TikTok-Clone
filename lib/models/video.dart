// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class Video {

  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePicture;
  
    // Constructor
  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePicture,
  });


        // To Json


    Map<String, dynamic> toJson() => {
        "username" : username,
        "uid" : uid,
        "id" : id,
        "likes" : likes,
        "commentCount" : commentCount,
        "shareCount" : shareCount,
        "songName" : songName,
        "caption" : caption,
        "videoUrl" : videoUrl,
        "thumbnail" : thumbnail,
        "profilePicture" : profilePicture,

    };


    // FROM JSON --- From snap

  static Video fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String ,dynamic>;

    return Video(
      username: snapshot['username'], 
      uid: snapshot['uid'], 
      id: snapshot['id'], 
      likes: snapshot['likes'], 
      commentCount: snapshot['commentCount'], 
      shareCount: snapshot['shareCount'], 
      songName: snapshot['songName'], 
      caption: snapshot['caption'], 
      videoUrl: snapshot['videoUrl'], 
      thumbnail: snapshot['thumbnail'], 
      profilePicture: snapshot['profilePicture']
      );
  }

}
