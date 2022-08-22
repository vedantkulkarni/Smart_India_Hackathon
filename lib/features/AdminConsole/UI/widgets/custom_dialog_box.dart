import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class CustomDialogBox extends StatefulWidget {
  final Widget widget;
  CustomDialogBox({Key? key, required this.widget}) : super(key: key);

  @override
  State<CustomDialogBox> createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: whiteColor),
            child: widget.widget),
      ),
    );
  }
}
