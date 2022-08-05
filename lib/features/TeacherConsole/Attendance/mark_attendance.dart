import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';

class MarkAttendnacePage extends StatefulWidget {
  List<CameraDescription> cameras;
  MarkAttendnacePage({Key? key, required this.cameras}) : super(key: key);

  @override
  State<MarkAttendnacePage> createState() => _MarkAttendnacePageState(cameras);
}

class _MarkAttendnacePageState extends State<MarkAttendnacePage> {
  late CameraController controller;
  final _cameras;
  _MarkAttendnacePageState(this._cameras);
  @override
  void initState() {
    super.initState();

    controller = CameraController(_cameras[0], ResolutionPreset.veryHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;
    print("hello");
    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {}
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CameraPreview(controller),
      // Scaffold(
      //   body: Container(
      //     color: blackColor,
      //     height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of(context).size.width,
      //   ),
      // ),

      CameraUIOverlay(
        cameraController: controller,
      )
    ]);
  }
}

class CameraUIOverlay extends StatefulWidget {
  final CameraController cameraController;
  const CameraUIOverlay({Key? key, required this.cameraController})
      : super(key: key);

  @override
  State<CameraUIOverlay> createState() => _CameraUIOverlayState();
}

class _CameraUIOverlayState extends State<CameraUIOverlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
          child: Column(
        children: [
          const Spacer(),
          FloatingActionButton(
            backgroundColor: backgroundColor,
            onPressed: () async {
              XFile? studentCapture =
                  await widget.cameraController.takePicture();
              widget.cameraController.pausePreview();
            },
            child: const Icon(
              Icons.camera_alt,
              size: 25,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: const AttendanceMarkedForStudentWidget(),
          )
        ],
      )),
    );
  }
}

class AttendanceMarkedForStudentWidget extends StatefulWidget {
  // final Student?? student;
  const AttendanceMarkedForStudentWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AttendanceMarkedForStudentWidget> createState() =>
      _AttendanceMarkedForStudentWidgetState();
}

class _AttendanceMarkedForStudentWidgetState
    extends State<AttendanceMarkedForStudentWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<AttendanceCubit, AttendanceState>(
        builder: (context, state) {
          if (state is AttendanceInitial || state is ScanningAttendance) {
            return Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/images/faceRecog.json', height: 100),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        "Please scan the face of student to record their Attendance",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: lightTextColor,
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.normal)),
                  ]),
            );
          } else if (state is ComparingResults) {
            return progressIndicator;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text("Scan Results",
                  style: TextStyle(
                      color: primaryColor,
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: textFieldFillColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const CircleAvatar(
                            backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=600",
                            ),
                            radius: 35,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text("Vedant Dattatray Kulkarni",
                              style: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  '23317',
                                  style: TextStyle(
                                      color: greyColor, fontFamily: 'Poppins'),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('|',
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'Poppins')),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Class 5A',
                                    style: TextStyle(
                                        color: greyColor,
                                        fontFamily: 'Poppins')),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('|',
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'Poppins')),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Present',
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'Poppins')),
                              ]),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.check)),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.delete))
                        ],
                      )
                    ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
