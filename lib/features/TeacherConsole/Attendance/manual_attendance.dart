import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/attendance_card.dart';
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
            // await showDialog(
            //     context: context,
            //     builder: (context) => Column(
            //           children: [
            //             const Text("Attendance Uploaded"),
            //             CustomTextButton(
            //                 onPressed: () {
            //                   Navigator.popUntil(context,
            //                       (route) => route.hasActiveRouteBelow);
            //                 },
            //                 text: 'Ok')
            //           ],
            //         ));
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
                            await attendanceCubit.uploadManualAttendance();
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
