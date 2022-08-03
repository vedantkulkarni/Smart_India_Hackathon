import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

class CustomTextButton extends StatefulWidget {
  final Function onPressed;
  final String text;
  Color? bgColor;
  Color? textColor;
  CustomTextButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.bgColor,
      this.textColor})
      : super(key: key);

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton>
    with TickerProviderStateMixin {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: ElevatedButton(
        clipBehavior: Clip.hardEdge,
        style: ElevatedButton.styleFrom(
            shadowColor: primaryColor,
            onSurface: primaryColor,
            side: const BorderSide(style: BorderStyle.none),
            primary: widget.bgColor ?? primaryColor,
            onPrimary: widget.textColor ?? whiteColor,
            textStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () => widget.onPressed(),
        child: Center(
          child: Text(
            widget.text,
          ),
        ),
      ),
    );
  }
}
