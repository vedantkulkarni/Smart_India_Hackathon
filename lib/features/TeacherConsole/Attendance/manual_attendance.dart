import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
      body: BlocBuilder<AttendanceCubit, AttendanceState>(
        builder: (context, state) {
          print("yoo");
          final attendance = attendanceCubit.attendanceMap;
          return Container(
              child: Column(
            children: [
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
                                  return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      columnCount: 4,
                                      child: ScaleAnimation(
                                        duration:
                                            const Duration(milliseconds: 900),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                        child: FadeInAnimation(
                                            child: AttendanceCard(
                                          onTap: () {
                                            attendanceCubit.toggleAttendance(
                                                classCubit
                                                    .classRoom
                                                    .students![index]
                                                    .studentID);
                                          },
                                          student: classCubit
                                              .classRoom.students![index],
                                          isPresent: attendance[classCubit
                                              .classRoom
                                              .students![index]
                                              .studentID]!,
                                        )),
                                      ));
                                }))),
                      ),
                    ),
              const Spacer(),
              CustomTextButton(onPressed: () {}, text: 'Submit')
            ],
          ));
        },
      ),
    );
  }
}
