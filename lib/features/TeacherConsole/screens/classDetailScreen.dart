import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/camera_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/face_detector.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/face_verify_with_profile_image.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/liveness.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/manual_attendance.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/ml_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_class_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/mark_attendance.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/screens/student_detail_screen.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/screens/teacher_console_student_card.dart';
import 'package:team_dart_knights_sih/injection_container.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../../core/constants.dart';

class ClassDetailScreen extends StatefulWidget {
  final String className;
  const ClassDetailScreen({required this.className, Key? key})
      : super(key: key);

  @override
  _ClassDetailScreenState createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final teacherCubit = BlocProvider.of<TeacherCubit>(context);
    final classCubit = BlocProvider.of<TeacherClassCubit>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<TeacherClassCubit, TeacherClassState>(
        builder: (context, state) {
          if (state is TeacherClassInitial) {
            return progressIndicator;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: h * 0.15,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                decoration: const BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    const Text(
                      'TE-11',
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 34,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Column(
                      children: const [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/24658039?v=4'),
                          radius: 15,
                        ),
                        Text('Vedant Kulkarni')
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Students',
                  style: TextStyle(
                      color: greyColor,
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: h * 0.5,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: blendColor, blurRadius: 15, spreadRadius: 10)
                    ],
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 6,
                      children: [
                        StaggeredGridTile.count(
                            crossAxisCellCount: 1,
                            mainAxisCellCount: 1,
                            child: TeacherConsoleStudentCard(
                                onTap: () {
                                  final student =
                                      BlocProvider.of<TeacherClassCubit>(
                                              context)
                                          .classRoom
                                          .students![0];
                                  final mlService = MLService(
                                      students:
                                          BlocProvider.of<TeacherClassCubit>(
                                                  context)
                                              .classRoom
                                              .students!);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return BlocProvider(
                                      create: (context) => AttendanceCubit(
                                          mode: classCubit
                                              .classRoom.attendanceMode,
                                          apiClient: getIt<AWSApiClient>(),
                                          faceDetectorService:
                                              getIt<FaceDetectorService>(),
                                          mlService: mlService,
                                          cameraService:
                                              getIt<CameraService>()),
                                      child: StudentDetailScreen(
                                          name: 'Harsh',
                                          email: 'atk@gmail.com',
                                          address: 'Pune',
                                          attendance: '89%',
                                          student: student,
                                          cameras: BlocProvider.of<
                                                  TeacherClassCubit>(context)
                                              .camerasList),
                                    );
                                  }));
                                },
                                student: classCubit.classRoom.students![0])),
                      ]),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextButton(
                  onPressed: () async {
                    if (classCubit.classRoom.students == null ||
                        classCubit.classRoom.students!.isEmpty) {
                      print("student list is empty");
                      return;
                    }
                    print(classCubit.classRoom.students);
                    final mlService =
                        MLService(students: classCubit.classRoom.students!);
                    Widget attendanceMode = await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) {
                      return MultiBlocProvider(
                          providers: [
                            BlocProvider.value(
                              value: teacherCubit,
                            ),
                            BlocProvider.value(
                              value:
                                  BlocProvider.of<TeacherClassCubit>(context),
                            ),
                            BlocProvider(
                                create: (context) => AttendanceCubit(
                                    apiClient: getIt<AWSApiClient>(),
                                    faceDetectorService:
                                        getIt<FaceDetectorService>(),
                                    cameraService: getIt<CameraService>(),
                                    mode: classCubit.classRoom.attendanceMode,
                                    studList: classCubit.classRoom.students,
                                    mlService: mlService))
                          ],
                          child: getAttendanceWidget(
                              classCubit.classRoom.attendanceMode, mlService));
                    }));
                  },
                  text: 'Mark Attendance')
            ],
          );
        },
      ),
    );
  }

  Widget getAttendanceWidget(
      VerificationStatus verificationStatus, MLService mlService) {
    switch (verificationStatus) {
      case VerificationStatus.FaceDetectedAndVerified:
        return MarkAttendnacePage(mlService: mlService);
      case VerificationStatus.FaceVerified:
        return const FaceVerifyWithProfileImage();
      case VerificationStatus.FaceVerifiedWithLiveness:
        return LivenessDetectionScreen();
      case VerificationStatus.ManualAttendance:
        return const ManualAttendance();

      default:
        return Container();
    }
  }
}
