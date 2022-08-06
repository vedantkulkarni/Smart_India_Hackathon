import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TeacherDetail extends StatefulWidget {
  final double height;
  final double width;
  final String name;
  final String email;
  final String phone;
  const TeacherDetail(
      {required this.height,
      required this.width,
      required this.email,
      required this.phone,
      required this.name,
      Key? key})
      : super(key: key);

  @override
  _TeacherDetailState createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        //width: w*0.3,
        height: widget.height * 0.24,
        decoration: BoxDecoration(
            color: secondaryColor,
            border: Border.all(color: greyColor),
            boxShadow: const [
              BoxShadow(color: navIconsColor, blurRadius: 2, spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [primaryColor, secondaryColor]),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: CircleAvatar(
                    radius: widget.height * 0.073,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundImage: const NetworkImage(
                        "https://images.pex"
                        "els.com/photos/220453/pexels-phot"
                        "o-220453.jpeg?auto=compress&c"
                        "s=tinysrgb&w=600",
                      ),
                      radius: widget.height * 0.07,
                    ),
                  ),
                ),
                Text(
                  'Teacher',
                  style: TextStyle(
                      color: navIconsColor,
                      fontSize: widget.height * 0.03,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: widget.height * 0.05,
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: widget.width * 0.05,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.email,
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: widget.width * 0.05,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.phone,
                  style: TextStyle(
                    color: backgroundColor,
                    fontSize: widget.width * 0.05,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
