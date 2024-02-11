import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/constant.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                        children: [
              Text(
                'TikTok',
                style: TextStyle(
                    fontSize: 35,
                    color: buttonColor,
                    fontWeight: FontWeight.w900),
              ),
              const Text('Register',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700)),
              const SizedBox(
                height: 25,
              ),
                  // Circle Avatar
              Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: buttonColor,
                  ),
                  Positioned(
                    bottom: 10,
                     right : 10,
                    child: InkWell(
                      onTap: () => authController.pickImage(),
                      child: Icon(Icons.add_a_photo)))
              ],),
              
              const SizedBox(
                height: 25,
              ),
                          // Username Field
              Container(
                width: width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                    inputController: _usernameController,
                    labelText: 'Username',
                    icon: Icons.person),
              ),
              const SizedBox(
                height: 30,
              ),
                  
                  // Email Field
              Container(
                width: width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                    inputController: _emailController,
                    labelText: 'Email',
                    icon: Icons.email),
              ),
              const SizedBox(
                height: 25,
              ),
                  // Password Field
              Container(
                width: width,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                    inputController: _passwordController,
                    isObsecure: true,
                    labelText: 'Password',
                    icon: Icons.lock),
              ),
               const SizedBox(
                height: 25,
              ),
                  
              
                               // Button
              InkWell(
                onTap: () => authController.registerUser(
                  _usernameController.text,
                  _emailController.text,
                   _passwordController.text, 
                   authController.profilePhoto!
                   ),
                child: Container(
                  width: width * .9,
                  height: 50,
                  decoration: BoxDecoration(
                 color: buttonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5)
                    )
                  ),
                  child: const Center(child: Text('Register' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w700),)),
                ),
              ),const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account ? ' , style: TextStyle(fontSize: 20),),
                  InkWell(
                    onTap: (){   
                      Navigator.push(context , MaterialPageRoute(builder: ((context) => LoginScreen())));
                      
                     
                    },
                    child: Text('Login' , style: TextStyle(fontSize: 20 , color: buttonColor),))
                ],
              )
                        
                        ],
                      ),
            )),
      ),
    );
  }
}
