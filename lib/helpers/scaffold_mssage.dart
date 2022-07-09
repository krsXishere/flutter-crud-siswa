import 'package:flutter/material.dart';

class ScaffoldMessage extends StatelessWidget {
  String message;
  Color? color;

  ScaffoldMessage({Key? key, required this.message, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog();
  }
}
