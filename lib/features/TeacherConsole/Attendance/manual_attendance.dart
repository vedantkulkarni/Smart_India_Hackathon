import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/attendance_card.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/attendance_dialog.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_class_cubit.dart';

class ManualAttendance extends StatefulWidget {
  const ManualAttendance({Key? key}) : super(key: key);

  @override
  State<ManualAttendance> createState() => _ManualAttendanceState();
}

class _ManualAttendanceState extends State<ManualAttendance> {
  Map<String, bool> attendanceMap = {};
  @override
  Widget build(BuildContext context) {
    final classCubit = BlocProvider.of<TeacherClassCubit>(context);
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return Scaffold(
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) async {
          if (state is AttendanceUploaded) {
            print("Uloaded attendance successfull");
          }
        },
        builder: (context, state) {
          final attendance = attendanceCubit.attendanceMap;
          if (state is AttendanceUploaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Attendance Successfull uploaded',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                CustomTextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Go back to class')
              ],
            );
          } else if (state is UploadingAttendance) {
            return progressIndicator;
          }

          var presentStudents = attendanceCubit.presentStudents;
          var totalStudents = attendanceCubit.attendanceMap.length;
          return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  const Text(
                    'Mark Attendance',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FinalAttendanceDetails(
                    presentStudents: presentStudents,
                    totalStudents: totalStudents,
                  ),
                  classCubit.classRoom.students == null ||
                          classCubit.classRoom.students!.isEmpty
                      ? const Expanded(
                          child: SizedBox(
                            height: double.maxFinite,
                            child: Center(child: Text('No Students Added')),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            child: AnimationLimiter(
                                child: GridView.count(
                                    crossAxisSpacing: 10,
                                    crossAxisCount: 3,
                                    physics: const BouncingScrollPhysics(),
                                    children: List.generate(
                                        classCubit.classRoom.students!.length,
                                        (index) {
                                      return AnimationConfiguration
                                          .staggeredGrid(
                                              position: index,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              columnCount: 4,
                                              child: ScaleAnimation(
                                                duration: const Duration(
                                                    milliseconds: 900),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                child: FadeInAnimation(
                                                    child: AttendanceCard(
                                                  onTap: () {
                                                    attendanceCubit
                                                        .toggleAttendance(
                                                            classCubit
                                                                .classRoom
                                                                .students![
                                                                    index]
                                                                .studentID);
                                                  },
                                                  student: classCubit.classRoom
                                                      .students![index],
                                                  isPresent: attendance[
                                                      classCubit
                                                          .classRoom
                                                          .students![index]
                                                          .studentID]!,
                                                )),
                                              ));
                                    }))),
                          ),
                        ),
                  const Spacer(),
                  Center(
                    child: SizedBox(
                      height: 40,
                      width: 170,
                      child: CustomTextButton(
                          onPressed: () async {
                            final res = await showDialog(
                                context: context,
                                builder: (context) {
                                  return AttendanceDialog(
                                    presentStudents: presentStudents,
                                    totalStudents: totalStudents,
                                  );
                                });
                            if (res) {
                              await attendanceCubit.uploadManualAttendance();
                            }
                          },
                          text: 'Submit'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ));
        },
      ),
    );
  }
}

class FinalAttendanceDetails extends StatelessWidget {
  final int presentStudents;
  final int totalStudents;
  const FinalAttendanceDetails(
      {Key? key, required this.presentStudents, required this.totalStudents})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var percent = (presentStudents / totalStudents) * 100;
    var absentStudents = (totalStudents - presentStudents);
    return Container(
        height: MediaQuery.of(context).size.height * 0.15,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight),
            boxShadow: const [
              BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10)
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Attendance',
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  '${percent.toInt().toString()}%',
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Present : ${presentStudents.toString()}',
                  style: TextStyle(
                    color: whiteColor.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Absent : ${absentStudents.toString()}',
                  style: TextStyle(
                    color: whiteColor.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  'Total : ${totalStudents.toString()}',
                  style: TextStyle(
                    color: whiteColor.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
