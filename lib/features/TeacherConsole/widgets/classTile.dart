import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ClassTile extends StatelessWidget {
  final double width;
  final String classNo;
  final String noOfStd;
  final VoidCallback onTap;
  const ClassTile({
    required this.width,
    required this.onTap,
    required this.classNo,
    required this.noOfStd,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10)
          ],
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Class',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: width * 0.05,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  classNo,
                  style: TextStyle(
                      color: navIconsColor,
                      fontSize: width * 0.05,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  'Students',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: width * 0.05,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  noOfStd,
                  style: TextStyle(
                      color: navIconsColor,
                      fontSize: width * 0.05,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
