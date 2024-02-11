
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/upload_video_controller.dart';
import 'package:tiktok_clone/views/widgets/text_input.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({super.key,  required this.videoFile, required this.videoPath});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  
  late VideoPlayerController controller;
  
  TextEditingController _songNameController =TextEditingController();
  TextEditingController _captionController = TextEditingController();
  
  UploadVideoController uploadVideoController = Get.put(UploadVideoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
         controller = VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(false);
  }


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            SizedBox(
              height: height/1.5,
              width : width,
              child : VideoPlayer(controller),
            ),
            const SizedBox(
              height : 30
            ),
            SingleChildScrollView(
              scrollDirection : Axis.vertical,
              child : Column(
                mainAxisAlignment :  MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin : const EdgeInsets.symmetric(
                      horizontal : 10 ), 
                    width : width - 20,
                    child : TextInputField(
                      inputController: _songNameController, 
                      labelText: 'Song Name', 
                      icon: Icons.music_note),
                    
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    margin : const EdgeInsets.symmetric(
                      horizontal : 10 ), 
                    width : width - 20,
                    child : TextInputField(
                      inputController: _captionController, 
                      labelText: 'Caption', 
                      icon: Icons.closed_caption)
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed: () => uploadVideoController.uploadVideo(_songNameController.text, _captionController.text, widget.videoPath), 
                  child: const Text('Share!' , style: TextStyle(fontSize: 20 , color: Colors.white),))
                  
                  
             
                ]
              )
            )

          ],
        ),
      ),      
    );
  }
}