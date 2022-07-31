import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? value;
  final EdgeInsets padding;
  String? heading;
  Icon? prefixIcon;
  double? width;
  bool? enabled;

  CustomTextField(
      {Key? key,
       this.value,
      required this.hintText,
      required this.padding,
      this.heading,
      this.width,
      this.prefixIcon,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading == null
              ? Container()
              : Text(
                  heading!,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: lightTextColor),
                ),
          TextFormField(
            enabled: enabled??true,
            initialValue: value,
            decoration: InputDecoration(
                contentPadding: padding,
                prefixIcon: prefixIcon,
                fillColor: textFieldFillColor,
                filled: true,
                border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                hintText: hintText,
                hintStyle: const TextStyle(color: navIconsColor)),
          ),
        ],
      ),
    );
  }
}
