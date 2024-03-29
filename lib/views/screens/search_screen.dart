
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/search_controller.dart';
import 'package:tiktok_clone/models/user_model.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
SearchScreen({super.key});


  UserSearchController searchController = Get.put(UserSearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(
       () => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.red,
          title: TextFormField(
            decoration: InputDecoration(
              filled: false,
              hintText: 'Search',
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.white
              )
              
              ),
              onFieldSubmitted: (value) => searchController.searchUser(value)
          ),
          ),
          body: searchController.searchedUsers.isEmpty ?
           const Center(child: Text('Search for users!', 
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
          ),): ListView.builder(
            itemCount: searchController.searchedUsers.length,
            itemBuilder: (context , index){
              var user = searchController.searchedUsers[index];
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => 
                  ProfileScreen(uid: user.uid)));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      user.profilePicture
                    ) ,
                  ),
                  title: Text(user.name , style: TextStyle(fontSize: 18 , color: Colors.white),),
                ));
                
            })
           )
       );     
    
  }
}