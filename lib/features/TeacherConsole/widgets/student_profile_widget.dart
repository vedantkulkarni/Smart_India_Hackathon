import 'package:flutter/material.dart';
import '../../../core/constants.dart';

class StudentProfileWidget extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  const StudentProfileWidget({required this.name,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue,
            ),
          ),
          Text(name,style: const TextStyle(
            color: backgroundColor,
            fontSize: 15,
          ),)
        ],
      ),
    );
  }
}
