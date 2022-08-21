import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? value;
  final EdgeInsets padding;
  String? heading;
  Icon? prefixIcon;
  double? width;
  bool? enabled;
  TextEditingController? textEditingController;

  CustomTextField(
      {Key? key,
      this.value,
      required this.hintText,
      required this.padding,
      this.heading,
      this.width,
      this.prefixIcon,
      this.enabled,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
        double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // ScreenUtil.init(context, designSize: Size(width, height));
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading == null
              ? Container()
              : Text(
                  heading!,
                  style:  TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      color: lightTextColor),
                ),
          TextFormField(
            controller: textEditingController,
            enabled: enabled ?? true,
            initialValue: value,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0),
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
