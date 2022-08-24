import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/camera_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/face_detector.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/manual_attendance.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/ml_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_class_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/face_verify_with_profile_image.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/screens/student_detail_screen.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/screens/teacher_console_student_card.dart';
import 'package:team_dart_knights_sih/injection_container.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../../core/constants.dart';
import '../Attendance/face_verification_attendance.dart';

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
                    Text(
                      widget.className,
                      style: const TextStyle(
                          color: blackColor,
                          fontSize: 34,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const CircleAvatar(
                      backgroundColor: primaryColor,
                      radius: 22,
                      child: CircleAvatar(
                        backgroundColor: whiteColor,
                        radius: 20,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://avatars.githubusercontent.com/u/24658039?v=4'),
                          radius: 18,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              classCubit.classRoom.currentAttendanceDate == null ||
                      classCubit.classRoom.currentAttendanceDate !=
                          TemporalDate(DateTime.now())
                  ? const Center(
                      child: Text(
                          'Attendance has not been marked yet.\nMark attendance to view analytics.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: lightTextColor,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal)))
                  : Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                      color: blendColor,
                                      blurRadius: 15,
                                      spreadRadius: 10)
                                ],
                                gradient: const LinearGradient(
                                    colors: [primaryColor, secondaryColor],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '79%',
                                    style: TextStyle(
                                        color: whiteColor.withOpacity(0.7),
                                        fontSize: 26,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    'Attendance',
                                    style: TextStyle(
                                        color: whiteColor.withOpacity(0.7),
                                        fontSize: 14,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: backgroundColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '34',
                                  style: TextStyle(
                                      color: blackColor,
                                      fontSize: 26,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal),
                                ),
                                Text(
                                  'present out of 45',
                                  style: TextStyle(
                                      color: greyColor,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.normal),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
              const SizedBox(
                height: 10,
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
              BlocProvider.of<TeacherClassCubit>(context)
                      .classRoom
                      .students!
                      .isEmpty
                  ? Container(
                      child: const Center(
                        child: Text('Student List is Empty'),
                      ),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          // height: h * 0.5,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: blendColor,
                                  blurRadius: 15,
                                  spreadRadius: 10)
                            ],
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: StaggeredGrid.count(
                              crossAxisCount: 4,
                              mainAxisSpacing: 1,
                              crossAxisSpacing: 6,
                              children: List.generate(
                                  BlocProvider.of<TeacherClassCubit>(context)
                                      .classRoom
                                      .students!
                                      .length, (index) {
                                return StaggeredGridTile.count(
                                    crossAxisCellCount: 1,
                                    mainAxisCellCount: 1,
                                    child: TeacherConsoleStudentCard(
                                        onTap: () {
                                          final student = BlocProvider.of<
                                                  TeacherClassCubit>(context)
                                              .classRoom
                                              .students![index];
                                          final mlService = MLService(
                                              students: BlocProvider.of<
                                                          TeacherClassCubit>(
                                                      context)
                                                  .classRoom
                                                  .students!);
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return MultiBlocProvider(
                                              providers: [
                                                BlocProvider.value(
                                                    value: BlocProvider.of<
                                                        TeacherCubit>(context)),
                                                BlocProvider.value(
                                                    value: BlocProvider.of<
                                                            TeacherClassCubit>(
                                                        context)),
                                              ],
                                              child: StudentDetailScreen(
                                                  name: 'Harsh',
                                                  email: 'atk@gmail.com',
                                                  address: 'Pune',
                                                  attendance: '89%',
                                                  student: student,
                                                  index: index,
                                                  cameras: BlocProvider.of<
                                                              TeacherClassCubit>(
                                                          context)
                                                      .camerasList),
                                            );
                                          }));
                                        },
                                        student: classCubit
                                            .classRoom.students![index]));
                              })),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 25,
              ),
              classCubit.classRoom.currentAttendanceDate == null ||
                      classCubit.classRoom.currentAttendanceDate !=
                          TemporalDate(DateTime.now())
                  ? Center(
                      child: SizedBox(
                        width: 170,
                        height: 40,
                        child: CustomTextButton(
                            onPressed: () async {
                              if (classCubit.classRoom.students == null ||
                                  classCubit.classRoom.students!.isEmpty) {
                                print("student list is empty");
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      titleTextStyle: const TextStyle(
                                          color: primaryColor,
                                          fontSize: 24,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold),
                                      contentTextStyle: const TextStyle(
                                          color: lightTextColor,
                                          fontSize: 16,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.normal),
                                      title: const Text('No Students !'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text('The student list is empty.'),
                                            Text(
                                                'Please ask your admin to assign students to your class.'),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text(
                                            'Ok',
                                            style: TextStyle(
                                                color: blackColor,
                                                fontSize: 18,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                                return;
                              }
                              // print(classCubit.classRoom.students);
                              final mlService =
                                  MLService(students: [...classCubit.studentList]);
                              bool? isMarkSuccessfull;
                              await Navigator.of(context)
                                  .push<bool>(MaterialPageRoute(builder: (_) {
                                return MultiBlocProvider(
                                    providers: [
                                      BlocProvider.value(
                                        value: teacherCubit,
                                      ),
                                      BlocProvider.value(
                                        value:
                                            BlocProvider.of<TeacherClassCubit>(
                                                context),
                                      ),
                                      BlocProvider(
                                          create: (_) => AttendanceCubit(
                                              apiClient: getIt<AWSApiClient>(),
                                              faceDetectorService:
                                                  getIt<FaceDetectorService>(),
                                              cameraService:
                                                  getIt<CameraService>(),
                                              mode: classCubit
                                                  .classRoom.attendanceMode,
                                              teacher: teacherCubit.teacher,
                                              studList: classCubit.studentList,
                                              mlService: mlService))
                                    ],
                                    child: getAttendanceWidget(
                                        classCubit.classRoom.attendanceMode,
                                        mlService));
                                // child: Scaffold(
                                //   body: progressIndicator,
                                // ));
                              }));

                              if (isMarkSuccessfull == null ||
                                  isMarkSuccessfull == false) {
                                print("Attendance Not marked");
                              } else {}
                              classCubit.fetchClassRoomDetailsForTeacher(
                                  classRoomID: classCubit.classRoom.id);
                            },
                            text: 'Mark Attendance'),
                      ),
                    )
                  : const Center(
                      child: Text('Attendance Already marked for today !',
                          style: TextStyle(
                              color: lightTextColor,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal))),
              const SizedBox(
                height: 40,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getAttendanceWidget(
    VerificationStatus verificationStatus,
    MLService mlService,
  ) {
    switch (verificationStatus) {
      case VerificationStatus.FaceDetectedAndVerified:
        // return MarkAttendnacePage(mlService: mlService);
        // return const StaticFaceScan();
        return  FaceVerifyScreen(verificationStatus: VerificationStatus.FaceDetectedAndVerified,);
      case VerificationStatus.FaceVerified:
        return const FaceVerifyWithProfileImage();
      case VerificationStatus.FaceVerifiedWithLiveness:
        return FaceVerifyScreen(verificationStatus: VerificationStatus.FaceVerifiedWithLiveness);
      case VerificationStatus.ManualAttendance:
        return const ManualAttendance();

      default:
        return Container();
    }
  }
}
