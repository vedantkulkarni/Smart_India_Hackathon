import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/leave_application/Screens/Leave_Apply/Leave_apply.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/s3_service.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Attendance/add_student_facial_data.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_class_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/teacher_cubit.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/amplify_storage_s3_service.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/widgets/future_image.dart';
import '../../../core/constants.dart';
import '../../../injection_container.dart';
import '../../../models/Student.dart';
import '../../AdminConsole/Backend/aws_api_client.dart';
import '../Attendance/camera_service.dart';
import '../Attendance/face_detector.dart';
import '../Attendance/ml_service.dart';

class StudentDetailScreen extends StatefulWidget {
  final String email;
  final String address;
  final String name;
  final String attendance;
  List<CameraDescription> cameras;
  Student? student;
  int index;
  StudentDetailScreen(
      {required this.name,
      required this.email,
      required this.address,
      required this.attendance,
      required this.cameras,
      required this.index,
      this.student,
      Key? key})
      : super(key: key);

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  final ImagePicker _picker = ImagePicker();

  void pickImage() async {
    // Pick an image
    // final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    // Capture a photo
    final XFile? photo =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 15);
    // Pick a video
    // final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
    // Capture a video
    // final XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    // Pick multiple images
    // final List<XFile>? images = await _picker.pickMultiImage();
    // File myFile = File(photo!.path);
    // await uploadFile(file: myFile);
    var dURL = await uploadImage(photo!, widget.student!.studentID);
    var updatedStudent = widget.student!.copyWith(profilePhoto: dURL);
    widget.student = await BlocProvider.of<TeacherClassCubit>(context)
        .updateStudent(student: updatedStudent);
    await BlocProvider.of<TeacherClassCubit>(context)
        .fetchClassRoomDetailsForTeacher(
            classRoomID: widget.student!.classRoomStudentsId!);
    setState(() {});
    print('uploaded');
  }

  var i = Image.network("https://images.pex"
      "els.com/photos/220453/pexels-phot"
      "o-220453.jpeg?auto=compress&c"
      "s=tinysrgb&w=600");

  @override
  Widget build(BuildContext context) {
    // final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: CircleAvatar(
                  radius: 74,
                  backgroundColor: primaryColor,
                  child: CircleAvatar(
                    radius: 72,
                    backgroundColor: backgroundColor,
                    child:  FutureImage(imageKey: widget.student!.profilePhoto??'')
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.student!.studentName,
                style: const TextStyle(
                    color: blackColor,
                    fontSize: 26,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Email',
                          style: TextStyle(
                              color: lightTextColor,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          widget.email,
                          style: const TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Address',
                          style: TextStyle(
                              color: lightTextColor,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          widget.address,
                          style: const TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Attendance',
                          style: TextStyle(
                              color: lightTextColor,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          widget.attendance,
                          style: const TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              widget.student!.modelData == null
                  ? SizedBox(
                      height: 40,
                      width: 200,
                      child: CustomTextButton(
                          onPressed: () async {
                            print(widget.student);
                            final classCubit =
                                BlocProvider.of<TeacherClassCubit>(context);
                            final teacherCubit =
                                BlocProvider.of<TeacherCubit>(context);
                            final mlService = MLService(
                                students:
                                    BlocProvider.of<TeacherClassCubit>(context)
                                        .classRoom
                                        .students!);

                            var res = await Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (ctx) => BlocProvider(
                                          create: (_) => AttendanceCubit(
                                              studList: BlocProvider.of<
                                                          TeacherClassCubit>(
                                                      context)
                                                  .classRoom
                                                  .students!,
                                              teacher: teacherCubit.teacher,
                                              mode: classCubit
                                                  .classRoom.attendanceMode,
                                              apiClient: getIt<AWSApiClient>(),
                                              faceDetectorService:
                                                  getIt<FaceDetectorService>(),
                                              mlService: mlService,
                                              cameraService:
                                                  getIt<CameraService>()),
                                          child: AddStudentFacialData(
                                            student: widget.student!,
                                            mlService: mlService,
                                          ),
                                        )));
                            if (res != null) {
                              await classCubit.fetchClassRoomDetailsForTeacher(
                                  classRoomID: classCubit.classRoom.id);
                              setState(() {
                                widget.student = classCubit
                                    .classRoom.students![widget.index];
                              });
                            }
                          },
                          text: 'Add Face Data'),
                    )
                  : Container(child: const Text('Face Data already added.')),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 40,
                  width: 200,
                  child: CustomTextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                LeaveApply(widget.student!.studentID)));
                      },
                      text: 'Apply for Leave')),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
