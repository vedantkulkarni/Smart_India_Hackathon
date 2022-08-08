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
        // height: widget.height * 0.24,
        // margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10)
          ],
          gradient: const LinearGradient(
              colors: [primaryColor, secondaryColor],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: CircleAvatar(
                    radius: 35,
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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Teacher',
                  style: TextStyle(
                      color: whiteColor.withOpacity(0.7),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: whiteColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    widget.email,
                    style: const TextStyle(
                      color: whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  Text(
                    widget.phone,
                    style: const TextStyle(
                      color: whiteColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
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
