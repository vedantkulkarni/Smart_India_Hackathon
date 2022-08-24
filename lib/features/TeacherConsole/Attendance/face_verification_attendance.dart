import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_face_api/face_api.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/mark_attendance.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:image/image.dart' as imglib;
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_class_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/custom_snackbar.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

import '../../../core/constants.dart';
import 'attendance_card.dart';
import 'attendance_dialog.dart';

class FaceVerifyScreen extends StatefulWidget {
  VerificationStatus verificationStatus;
  FaceVerifyScreen({Key? key, required this.verificationStatus})
      : super(key: key);

  @override
  State<FaceVerifyScreen> createState() => _FaceVerifyScreenState();
}

class _FaceVerifyScreenState extends State<FaceVerifyScreen> {
  imglib.Image? img;
  final ImagePicker _picker = ImagePicker();
  Future<InputImage> pickImage() async {
    // Pick an image
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // Capture a photo
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 15);
    img = imglib.decodeImage(await photo!.readAsBytes());

    InputImage inputImage = InputImage.fromFile(File(photo.path));

    return inputImage;
  }

  Future<bool> checkLiveness() async {
    FaceSDK.startLiveness().then((livenessResponse) {
      var response = LivenessResponse.fromJson(json.decode(livenessResponse));
      if (response!.liveness == LivenessStatus.PASSED) {
        return true;
      } else {
        return false;
      }
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final classCubit = BlocProvider.of<TeacherClassCubit>(context);
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    // final attendance = attendanceCubit.attendanceMap;
    // Student student = classCubitstudentList[0];
    return Scaffold(
      body: BlocConsumer<AttendanceCubit, AttendanceState>(
        listener: (context, state) {
          if(state is AttendanceUploaded) {
            showSnackBar(context, text: 'Attendance Uploaded Successfully');
            Navigator.pop(context);
          }
          else if(state is AttendanceStoredToLocalStore) {
            showSnackBar(context, text: 'Attendance Upload Failed Due to Network Error, A Local Copy Has Been Stored');
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is UploadingAttendance) return progressIndicator;

          return Container(
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
              classCubit.studentList.isEmpty
                  ? const Expanded(
                      child: SizedBox(
                        height: double.maxFinite,
                        child: Center(
                            child: Text(
                                'Please add face data of students to proceed with attendance',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: lightTextColor,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.normal))),
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
                                    classCubit.studentList.length, (index) {
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
                                          onTap: () async {
                                            if (attendanceCubit.cameraService
                                                    .cameraController ==
                                                null) {
                                              await attendanceCubit
                                                  .initCamera();
                                            }
                                            await Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return BlocProvider.value(
                                                value: attendanceCubit,
                                                child: MarkAttendnacePage(
                                                    mlService: attendanceCubit
                                                        .mlService),
                                              );
                                            }));
                                            setState(() {});
                                          },
                                          student:
                                              classCubit.studentList[index],
                                          isPresent: attendanceCubit.attendanceMap[classCubit
                                              .studentList[index].studentID]!,
                                        )),
                                      ));
                                }))),
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              SizedBox(
                height: 40,
                width: 170,
                child: CustomTextButton(
                  onPressed: () async {
                    if (widget.verificationStatus ==
                        VerificationStatus.FaceVerifiedWithLiveness) {
                         var result = await checkLiveness();
                        }
                    if (attendanceCubit.cameraService.cameraController ==
                        null) {
                      await attendanceCubit.initCamera();
                    }
                    await Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return BlocProvider.value(
                        value: attendanceCubit,
                        child: MarkAttendnacePage(
                            mlService: attendanceCubit.mlService),
                      );
                    }));
                    setState(() {});
                  },
                  text: 'Mark Randomly',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
                                presentStudents:
                                    attendanceCubit.presentStudents,
                                totalStudents: attendanceCubit.studList!.length,
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
