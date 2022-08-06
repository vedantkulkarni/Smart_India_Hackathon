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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          //height : 30,
          decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF64DD17),
                    Color(0xFF76FF03),
                    Color(0xFFB2FF59),
                  ])),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Class',
                      style: TextStyle(
                          color: backgroundColor,
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
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'No Of \nStudents',
                      style: TextStyle(
                          color: backgroundColor,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
