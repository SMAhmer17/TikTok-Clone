

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constant.dart';
import 'package:tiktok_clone/models/user_model.dart';

class UserSearchController extends GetxController{
  
  final Rx<List<User>> _searchUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchUsers.value;


  searchUser(String typedUser)async{
    _searchUsers.bindStream(
      firestore.collection('users').where('name' , isGreaterThanOrEqualTo: typedUser).
      snapshots().map((QuerySnapshot query){
        List<User> returnVal = [];
        for (var element in query.docs){
          returnVal.add(User.fromSnap(element));
        }
        return returnVal;
      })
    );
  }
}