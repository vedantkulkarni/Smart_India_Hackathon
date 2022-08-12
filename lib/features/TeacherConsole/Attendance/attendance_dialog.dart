

import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/manual_attendance.dart';

import '../../../core/constants.dart';

class AttendanceDialog extends StatefulWidget {
  final int totalStudents;
  final int presentStudents;
   AttendanceDialog({Key? key,required this.presentStudents,required this.totalStudents}) : super(key: key);

  @override
  State<AttendanceDialog> createState() => _AttendanceDialogState();
}

class _AttendanceDialogState extends State<AttendanceDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Do you want to submit this attendance ?',
        style: TextStyle(
          color: blackColor,
          fontSize: 18,
          fontWeight: FontWeight.normal,
          fontFamily: 'Poppins',
        ),
      ),
      content: FinalAttendanceDetails(presentStudents: widget.presentStudents,totalStudents: widget.totalStudents),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text(
              'Ok',
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            )),
      ],
    );
  }
}
