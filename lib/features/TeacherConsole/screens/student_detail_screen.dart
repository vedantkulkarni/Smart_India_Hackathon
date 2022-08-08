import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/add_student_facial_data.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';

import '../../../core/constants.dart';
import '../../../models/Student.dart';

class StudentDetailScreen extends StatelessWidget {
  final String email;
  final String address;
  final String name;
  final String attendance;
  List<CameraDescription> cameras;
  Student? student;
  StudentDetailScreen(
      {required this.name,
      required this.email,
      required this.address,
      required this.attendance,
      required this.cameras,
      this.student,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const CircleAvatar(
                radius: 74,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://images.pex"
                    "els.com/photos/220453/pexels-phot"
                    "o-220453.jpeg?auto=compress&c"
                    "s=tinysrgb&w=600",
                  ),
                  radius: 70,
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                    color: navIconsColor,
                    fontSize: 33,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Email:- ',
                        style: TextStyle(
                            color: backgroundColor,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        email,
                        style: const TextStyle(
                            color: backgroundColor,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Address:- ',
                        style: TextStyle(
                            color: backgroundColor,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        address,
                        style: const TextStyle(
                            color: backgroundColor,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Attendance:- ',
                        style: TextStyle(
                            color: backgroundColor,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        attendance,
                        style: const TextStyle(
                            color: backgroundColor,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              CustomTextButton(
                  onPressed: () {
                    print(student);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => BlocProvider.value(
                              value: BlocProvider.of<AttendanceCubit>(context),
                              child: AddStudentFacialData(
                                  cameras: cameras, student: student!),
                            )));
                  },
                  text: 'Add Face Data')
            ],
          ),
        ),
      ),
    );
  }
}
