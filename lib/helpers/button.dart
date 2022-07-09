import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DefaultButton extends StatelessWidget {
  String text;
  Function()? onPressed;
  double width;
  Color color;

  DefaultButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
