import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final EdgeInsets padding;

  const CustomTextField({Key? key,required this.hintText,required this.labelText,required this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        
        decoration: InputDecoration(
          fillColor: secondaryColor.withOpacity(0.1),
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: secondaryColor, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          labelStyle: const TextStyle(color: primaryColor),
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}
