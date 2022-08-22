import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

class CustomTextButton extends StatefulWidget {
  final Function onPressed;
  final String text;
  Color? bgColor;
  Color? textColor;
  Icon? icon;
  CustomTextButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.bgColor,
      this.textColor,
      this.icon})
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
      height: 30,
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
        ),
        onPressed: () => widget.onPressed(),
        child: widget.icon == null
            ? Center(
                child: Text(
                  widget.text,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.text,
                  ),
                  Icon(
                    widget.icon!.icon,
                    color: whiteColor,
                    size: 18,
                  )
                ],
              ),
      ),
    );
  }
}
