import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

class AddStudentFacialData extends StatefulWidget {
  List<CameraDescription> cameras;
  Student student;
  AddStudentFacialData({Key? key, required this.cameras, required this.student})
      : super(key: key);

  @override
  State<AddStudentFacialData> createState() =>
      _AddStudentFacialDataState(cameras);
}

class _AddStudentFacialDataState extends State<AddStudentFacialData> {
  late CameraController controller;
  final _cameras;
  _AddStudentFacialDataState(this._cameras);
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
    return Scaffold(
      body: Container( 
          child: Stack(children: [
        CameraPreview(controller),
        // Container(
        //   color: blackColor,
        //   height: double.maxFinite,
        //   width: double.maxFinite,
        // ),
        AddFaceCamOverLay(
          cameraController: controller,
          student: widget.student,
        )
      ])),
    );
  }
}

class AddFaceCamOverLay extends StatefulWidget {
  final CameraController cameraController;
  Student student;
  AddFaceCamOverLay(
      {Key? key, required this.cameraController, required this.student})
      : super(key: key);

  @override
  State<AddFaceCamOverLay> createState() => _AddFaceCamOverLayState();
}

class _AddFaceCamOverLayState extends State<AddFaceCamOverLay> {
  @override
  Widget build(BuildContext context) {
    final attendanceCubit = BlocProvider.of<AttendanceCubit>(context);
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          const Spacer(),
          FloatingActionButton(onPressed: () async {
            XFile? studentCapture = await widget.cameraController.takePicture();
            widget.cameraController.pausePreview();
            // await attendanceCubit.addFaceDataToStudent(
            //     captureImage: studentCapture, student: widget.student);
          })
        ],
      ),
    );
  }
}
