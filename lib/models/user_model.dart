import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String profilePicture;
  String email;
  String uid;

  User({
    required this.name,
    required this.profilePicture,
    required this.email,
    required this.uid,
  });


    // send data to db --- To json
Map <String , dynamic> toJson() => {

  "name" : name,
  "profilePicture" : profilePicture,
  "email" : email,
  "uid" : uid
  };


      
    // fetch data from db --- from json
    // to convert our snapshot into User model
  static User fromSnap(DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String , dynamic>;
    return User(
      name: snapshot['name'],
      profilePicture: snapshot['profilePicture'], 
      email:snapshot['email'] , 
      uid: snapshot['uid']);
  }
  }

//   User copyWith({
//     String? name,
//     String? profilePicture,
//     String? email,
//     String? uid,
//   }) {
//     return User(
//       name: name ?? this.name,
//       profilePicture: profilePicture ?? this.profilePicture,
//       email: email ?? this.email,
//       uid: uid ?? this.uid,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'profilePicture': profilePicture,
//       'email': email,
//       'uid': uid,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       name: map['name'] as String,
//       profilePicture: map['profilePicture'] as String,
//       email: map['email'] as String,
//       uid: map['uid'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'User(name: $name, profilePicture: $profilePicture, email: $email, uid: $uid)';
//   }

//   @override
//   bool operator ==(covariant User other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.name == name &&
//       other.profilePicture == profilePicture &&
//       other.email == email &&
//       other.uid == uid;
//   }

//   @override
//   int get hashCode {
//     return name.hashCode ^
//       profilePicture.hashCode ^
//       email.hashCode ^
//       uid.hashCode;
//   }
// }
