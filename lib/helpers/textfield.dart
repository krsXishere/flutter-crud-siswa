import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class GenTextfield extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  String hintName;
  bool isObscure;
  TextInputType inputType;
  bool isEnable;
  GestureDetector? suffixIcon;

  GenTextfield({
    Key? key,
    required this.controller,
    required this.hintName,
    this.isObscure = false,
    required this.suffixIcon,
    this.inputType = TextInputType.text,
    this.isEnable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      enabled: isEnable,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintName,
        hintStyle: const TextStyle(color: Colors.black26),
        filled: true,
        fillColor: Colors.grey[300],
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}
