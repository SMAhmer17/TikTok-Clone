
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/constant.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController inputController;
  final String labelText;
  final bool isObsecure;
  final IconData icon;

  const TextInputField({super.key, 
  required this.inputController, 
  required this.labelText, 
  this.isObsecure = false, 
  required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: inputController,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          )
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: borderColor,
          )
        ),
      ),
      obscureText: isObsecure,
    );
  }
}