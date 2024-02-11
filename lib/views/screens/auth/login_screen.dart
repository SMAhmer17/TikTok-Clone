import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/constant.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/views/widgets/text_input.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Center(
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
            const Text('Login',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700)),
            const SizedBox(
              height: 25,
            ),
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
              height: 30,
            ),
            InkWell(
              onTap: () => authController.loginUser(
                  _emailController.text, _passwordController.text),

              // Button
              child: Container(
                width: width * .9,
                height: 50,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Center(
                    child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account ? ',
                  style: TextStyle(fontSize: 20),
                ),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => SignupScreen())));
                      print('Register');
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 20, color: buttonColor),
                    ))
              ],
            )
          ],
        )),
      ),
    );
  }
}
