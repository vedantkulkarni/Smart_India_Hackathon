import 'package:flutter/material.dart';

import '../../core/constants.dart';

void showSnackBar(BuildContext context, {required String text}) {
  final snackBar = SnackBar(
    content: Text(
      text,
      style: const TextStyle(
          color: whiteColor,
          fontSize: 14,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal),
    ),
    backgroundColor: primaryColor,
    behavior: SnackBarBehavior.floating,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
