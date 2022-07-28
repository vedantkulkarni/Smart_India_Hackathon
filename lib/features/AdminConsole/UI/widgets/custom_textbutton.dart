import 'package:flutter/material.dart';

class CustomTextButton extends StatefulWidget {
  final Function onPressed;
  final String text;
  CustomTextButton({Key? key,required this.onPressed,required this.text}) : super(key: key);

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(child: Text(widget.text),onPressed: ()=>widget.onPressed()),
    );
  }
}