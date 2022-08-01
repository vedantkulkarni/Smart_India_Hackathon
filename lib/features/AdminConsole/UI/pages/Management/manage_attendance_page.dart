import 'package:flutter/material.dart';

import '../../../../../core/constants.dart';

class ManageAttendancePage extends StatefulWidget {
  const ManageAttendancePage({Key? key}) : super(key: key);

  @override
  State<ManageAttendancePage> createState() => _ManageAttendancePageState();
}

class _ManageAttendancePageState extends State<ManageAttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Container()],
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: blackColor),
      ),
      body: Container(
          child: const Center(
        child: Text('Attendance page'),
      )),
    );
  }
}
