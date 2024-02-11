// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {

String username;
String comment;
final datePublish;
List likes;
String profilePicture;
String uid;
String id;

  Comment({
    required this.username,
    required this.comment,
    required this.likes,
    required this.datePublish,
    required this.profilePicture,
    required this.uid,
    required this.id,
  });

  Map<String,dynamic> toJson()=>{
    "username" : username,
    "comment" : comment,
    "likes" : likes ,
    "datePublish" : datePublish,
    "profilePicture" : profilePicture,
    "uid" : uid,
    "id" : id
  };

  static Comment fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return Comment(
      username: snapshot['username'], 
      comment: snapshot['comment'], 
      likes: snapshot['likes'] , 
      datePublish: snapshot['datePublish'], 
      profilePicture: snapshot['profilePicture'], 
      uid: snapshot['uid'], 
      id: snapshot['id']);
  }
}
