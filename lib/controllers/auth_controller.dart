import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants/constant.dart';
import 'package:tiktok_clone/models/user_model.dart' as model;
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController {

  // To check if user is already log in 

  late Rx<User?> _user;
  // getting user
  User get user => _user.value!;

   // To find an instance of authController
  static AuthController instance = Get.find();


  // It runs after init fn means 1 frame after  init
  @override
  void onReady(){
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user , _setInitialScreen);

  }

  _setInitialScreen(User? user){
    if(user == null){
      Get.offAll(() => LoginScreen());
    }else{
      Get.offAll(() =>const  HomeScreen());
    }    

  }

  // Pick Image function

  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;
  
  
  void pickImage()async{
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedImage != null){
      Get.snackbar('Profile Picture', 'You have successfully selected your profile picture!');
    }

    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }



  // upload image to firebase storage
  Future<String> _uploadToStorage(File? image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image!);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user

  void registerUser(
      String username, String email, String password, File image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // save out user to auth and firebase firestore

        UserCredential userCred = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        // upload to user credentials to firebase firestore
        String downloadUrl = await _uploadToStorage(image);
        // User Model
        model.User user = model.User(
            name: username,
            profilePicture: downloadUrl,
            email: email,
            uid: userCred.user!.uid);

          await firestore.collection('user').doc(userCred.user!.uid).set(user.toJson());
        }else{
           Get.snackbar('Error Creating Account', 'Please enter all the fields');
        }
    } catch (e) {
      Get.snackbar('Error Creating Account', e.toString());
    }
  }


    /***************** Login User ******************/

    void loginUser(String email , String password)async{
      try{
          if(email.isNotEmpty && password.isNotEmpty){
                
                await firebaseAuth.signInWithEmailAndPassword(email: email, password: password).then((value) {
                  Get.snackbar('Congratulations!', 'You have successfully login to your account');
                  Get.to(HomeScreen());
                });
                
          }else{
            Get.snackbar('Error log in to your account', 'Please enter all the fields');
          }
      }catch(e){
        Get.snackbar('Error log in to your account', e.toString());
      }
    }

     /***************** Log out ******************/

    signOut()async{
      await firebaseAuth.signOut();
    }
}
