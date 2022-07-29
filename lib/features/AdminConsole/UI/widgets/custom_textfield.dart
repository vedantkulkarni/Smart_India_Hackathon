import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final EdgeInsets padding;
  Icon? prefixIcon;
  double? width;

  CustomTextField(
      {Key? key,
      required this.hintText,
      required this.labelText,
      required this.padding,
      this.width,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextFormField(
        
        decoration: InputDecoration(
            contentPadding: padding,
            prefixIcon: prefixIcon,
            fillColor: textFieldFillColor,
            filled: true,
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
