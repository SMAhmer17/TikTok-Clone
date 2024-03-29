
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants/constant.dart';
import 'package:tiktok_clone/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;
class CommentsScreen extends StatelessWidget {
  final String id;
   CommentsScreen({super.key, required this.id});


  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController =Get.put(CommentController());
  
  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Obx(()
                 {
                    return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context ,index){
                        final comment = commentController.comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          backgroundImage: NetworkImage(comment.profilePicture),
                        ),
                        title: Row(
                          children: [
                            Text(comment.username , style: TextStyle(fontSize: 15 , color: Colors.red , fontWeight: FontWeight.w700),),
                            Text(comment.comment  , style: TextStyle(fontSize: 15 , color: Colors.red , fontWeight: FontWeight.w700),)
                          ],
                        ),
                        subtitle: Row(children: [
                          Text(
                            tago.format(
                            comment.datePublish.toDate(),
                            ), style: TextStyle(fontSize: 12 , color: Colors.white),),
                        const SizedBox(width: 10,),
                        Text('${comment.likes.length} likes' , style: TextStyle(fontSize: 12 , color: Colors.white),),
                    
                        ],),
                        trailing: InkWell(
                          onTap: () => commentController.likeComment(comment.id),
                          child: Icon(Icons.favorite , size: 25 , 
                          color: comment.likes.contains(authController.user.uid) ? Colors.red : Colors.white,)),
                      );
                    });
                  }
                )
                ),
                const Divider(),
                ListTile(
                  title: TextFormField(
                    controller: _commentController,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Comment',
                      labelStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    ),
                  ),
                trailing: TextButton(onPressed: () => commentController.postComment(_commentController.text), 
                child:Text('Send' , style: TextStyle(fontSize: 16 , color: Colors.white),) ),
                ),
                
              ],
          ),
        ),
      )
    );
  }
}