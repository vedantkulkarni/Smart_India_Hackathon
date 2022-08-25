import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';

class DialogUtils {
  static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,
      {required String title,
      String okBtnText = "Ok",
      String cancelBtnText = "Cancel",
      Widget? content,
      required VoidCallback okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: content ?? Text("content"),
            actions: <Widget>[
              // FlatButton(
              //   child: Text(okBtnText),
              //   onPressed: okBtnFunction,

              // ),
              CustomTextButton(onPressed: okBtnFunction, text: okBtnText),
              CustomTextButton(
                  onPressed: () => Navigator.pop(context), text: cancelBtnText)
            ],
          );
        });
  }
}
