import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class StudentProfileWidget extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const StudentProfileWidget({
    required this.name,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          // height: 10,
          // width: 10,
          decoration: BoxDecoration(
              color: greyColor, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              SizedBox(
                height: 2,
              ),
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue,
              ),
              Text(
                name,
                style: const TextStyle(
                  color: backgroundColor,
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
