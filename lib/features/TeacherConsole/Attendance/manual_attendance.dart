import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/attendance_card.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/attendance_dialog.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_class_cubit.dart';
import 'package:intl/intl.dart';

class ManualAttendance extends StatefulWidget {
  const ManualAttendance({Key? key}) : super(key: key);

  @override
  State<ManualAttendance> createState() => _ManualAttendanceState();
}

class _ManualAttendanceState extends State<ManualAttendance> {
  // Map<String, bool> attendanceMap = {};
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.now()),
                        style: const TextStyle(
                          color: blackColor,
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        DateFormat.Hm().format(DateTime.now()),
                        style: const TextStyle(
                          color: blackColor,
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: FinalAttendanceDetails(
                      presentStudents: attendanceCubit.presentStudents,
                      totalStudents: attendanceCubit.attendanceMap.length),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Attendance successfully uploaded !!',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 40,
                  width: 140,
                  child: CustomTextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      text: 'Go back to class'),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            );
          } else if (state is UploadingAttendance) {
            return progressIndicator;
          } else if (state is AttendanceStoredToLocalStore) {
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.now()),
                        style: const TextStyle(
                          color: blackColor,
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        DateFormat.Hm().format(DateTime.now()),
                        style: const TextStyle(
                          color: blackColor,
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: FinalAttendanceDetails(
                      presentStudents: attendanceCubit.presentStudents,
                      totalStudents: attendanceCubit.attendanceMap.length),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Due to lack of internet connection, attendance has been stored locally. Kindly upload once network is available',
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 40,
                  width: 140,
                  child: CustomTextButton(
                      onPressed: () {
                        Navigator.pop(context, true);
                      },
                      text: 'Go back to class'),
                ),
                const SizedBox(
                  height: 60,
                ),
              ],
            );
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
                    'Manual Attendance',
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
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                  // const Spacer(),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: SizedBox(
                      height: 40,
                      width: 170,
                      child: CustomTextButton(
                          onPressed: () async {
                            final res = await showDialog(
                                context: context,
                                builder: (_) {
                                  return AttendanceDialog(
                                    presentStudents: presentStudents,
                                    totalStudents: totalStudents,
                                  );
                                });
                            print(res);

                            if (res) {
                              await attendanceCubit.uploadAttendance(
                                  classRoom: classCubit.classRoom);
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
