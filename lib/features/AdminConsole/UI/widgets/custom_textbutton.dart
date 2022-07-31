import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

class CustomTextButton extends StatefulWidget {
  final Function onPressed;
  final String text;
  Color? bgColor;
   CustomTextButton(
      {Key? key, required this.onPressed, required this.text,this.bgColor})
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
      child: Center(
        child: Material(
          child: InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onHighlightChanged: (value) {
              setState(() {
                isTapped = value;
              });
            },
            onTap: () {
              widget.onPressed();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastLinearToSlowEaseIn,
              height: isTapped ? 35 : 40,
              width: isTapped ? 130 : 140,
              decoration: BoxDecoration(
                color: widget.bgColor??primaryColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal,
                      color: whiteColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
