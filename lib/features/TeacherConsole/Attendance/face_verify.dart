// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';
// import 'package:team_dart_knights_sih/features/TeacherConsole/Backend/cubit/attendance_cubit.dart';
// // import 'package:flutter_face_api/face_api.dart' as Regula;
// import '../Backend/cubit/teacher_class_cubit.dart';
// import '../screens/teacher_console_student_card.dart';

// class FaceVerify extends StatefulWidget {
//   XFile capturedImage;

//   FaceVerify({
//     Key? key,
//     required this.capturedImage,
//   }) : super(key: key);

//   @override
//   State<FaceVerify> createState() => _FaceVerifyState(
//         capturedImage: capturedImage,
//       );
// }

// class _FaceVerifyState extends State<FaceVerify> {
//   var image1 = Regula.MatchFacesImage();
//   var image2 = Regula.MatchFacesImage();
//   XFile capturedImage;

//   Image? studentProfileImage;
//   var img1, img2;
//   _FaceVerifyState({required this.capturedImage});

//   var _similarity = '';

//   Future<Uint8List> getBytesOfNetworkImage(String imageUrl) async {
//     Uint8List bytes =
//         (await NetworkAssetBundle(Uri.parse(imageUrl)).load(imageUrl))
//             .buffer
//             .asUint8List();
//     return bytes;
//   }

//   // showAlertDialog(BuildContext context, bool first) => showDialog(
//   //   context: context,
//   //   builder: (BuildContext context) =>
//   //       // AlertDialog(title: const Text("Select option"), actions: [
//   //   // ignore: deprecated_member_use
//   //   FlatButton(
//   //       child: const Text("Use gallery"),
//   //       onPressed: () {
//   //       //   ImagePicker().getImage(source: ImageSource.gallery).then(
//   //       //       (value) => setImage(
//   //       //           first,
//   //       //           io.File(value!.path).readAsBytesSync(),
//   //       //           Regula.ImageType.PRINTED));
//   //       //   Navigator.pop(context);
//   //       // }),
//   //   // ignore: deprecated_member_use
//   //   FlatButton(
//   //       child: const Text("Use camera"),
//   //       onPressed: () {
//   //         Regula.FaceSDK.presentFaceCaptureActivity().then((result) =>
//   //             setImage(
//   //                 first,
//   //                 base64Decode(Regula.FaceCaptureResponse.fromJson(
//   //                         json.decode(result))!
//   //                     .image!
//   //                     .bitmap!
//   //                     .replaceAll("\n", "")),
//   //                 Regula.ImageType.LIVE));
//   //         Navigator.pop(context);
//   //       })
//   // ]));
//   setImage(bool first, List<int> imageFile, int type) {
//     if (imageFile == null) return;
//     setState(() => _similarity = "nil");
//     if (first) {
//       image1.bitmap = base64Encode(imageFile);
//       image1.imageType = type;
//       setState(() {
//         img1 = Image.memory(Uint8List.fromList(imageFile));
//       });
//     } else {
//       image2.bitmap = base64Encode(imageFile);
//       image2.imageType = type;
//       setState(() => img2 = Image.memory(Uint8List.fromList(imageFile)));
//     }
//   }

//   matchFaces() {
//     // print(image2.btmap);

//     if (image1.bitmap == null ||
//         image1.bitmap == "" ||
//         image2.bitmap == null ||
//         image2.bitmap == "") return;
//     setState(() => _similarity = "Processing...");
//     var request = Regula.MatchFacesRequest();
//     request.images = [image1, image2];
//     Regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
//       var response = Regula.MatchFacesResponse.fromJson(json.decode(value));
//       print(response!.exception!.errorCode);
//       Regula.FaceSDK.matchFacesSimilarityThresholdSplit(
//               jsonEncode(response.results), 0.75)
//           .then((str) {
//         var split = Regula.MatchFacesSimilarityThresholdSplit.fromJson(
//             json.decode(str));
//         setState(() => _similarity = split!.matchedFaces.isNotEmpty
//             ? ((split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2) +
//                 "%")
//             : "error");
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final classCubit = BlocProvider.of<TeacherClassCubit>(context);
//     return Scaffold(
//       body: BlocBuilder<AttendanceCubit, AttendanceState>(
//         builder: (context, state) {
//           if (state is StudentNotSelected) {
//             return StaggeredGrid.count(
//                 crossAxisCount: 4,
//                 mainAxisSpacing: 1,
//                 crossAxisSpacing: 6,
//                 children: List.generate(
//                     BlocProvider.of<TeacherClassCubit>(context)
//                         .classRoom
//                         .students!
//                         .length, (index) {
//                   return StaggeredGridTile.count(
//                       crossAxisCellCount: 1,
//                       mainAxisCellCount: 1,
//                       child: TeacherConsoleStudentCard(
//                           onTap: () {
//                             // Navigator.push(context,
//                             //     MaterialPageRoute(builder: (_) {
//                             //   return MultiBlocProvider(
//                             //     providers: [

//                             //       BlocProvider.value(
//                             //           value: BlocProvider.of<
//                             //               TeacherClassCubit>(context)),
//                             //     ],
//                             //     child: StudentDetailScreen(
//                             //         name: 'Harsh',
//                             //         email: 'atk@gmail.com',
//                             //         address: 'Pune',
//                             //         attendance: '89%',
//                             //         student: student,
//                             //         cameras: BlocProvider.of<
//                             //                 TeacherClassCubit>(context)
//                             //             .camerasList),
//                             //   );
//                             // }));
//                             BlocProvider.of<AttendanceCubit>(context)
//                                 .studentGotSelected(
//                                     student: BlocProvider.of<TeacherClassCubit>(
//                                             context)
//                                         .classRoom
//                                         .students![index]);
//                           },
//                           student: classCubit.classRoom.students![index]));
//                 }));
//           }

//           return Container(
//               child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               const Text('Face Verify'),
//               const SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 children: const [
//                   Text('Verified Students : '),
//                   Spacer(),
//                   Text('12')
//                 ],
//               ),
//               Row(
//                 children: const [Text('Remaining : '), Spacer(), Text('48')],
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Image.file(File(capturedImage.path)),
//                     // child: Image.network(
//                     //     (state as StudentSelected).student.profilePhoto!),
//                   ),
//                   Expanded(
//                     child: Image.network(
//                         (state as StudentSelected).student.profilePhoto!),
//                   ),
//                 ],
//               ),
//               CustomTextButton(
//                   onPressed: () {
//                     matchFaces();
//                   },
//                   text: 'Verify'),
//               CustomTextButton(
//                   onPressed: () async {
//                     // var firstImageasBytes = await getBytesOfNetworkImage(
//                     //     (state).student.profilePhoto!);
//                     var firstImageasBytes =
//                         await File(capturedImage.path).readAsBytes();
//                     setImage(true, firstImageasBytes, Regula.ImageType.PRINTED);
//                     // var secondImageAsBytes = await getBytesOfNetworkImage(
//                     //     (state).student.profilePhoto!);
//                     var secondImageAsBytes =
//                         await File(capturedImage.path).readAsBytes();
//                     setImage(false, secondImageAsBytes, Regula.ImageType.LIVE);
//                   },
//                   text: 'Set Both images'),
//               Text(_similarity)
//             ],
//           ));
//         },
//       ),
//     );
//   }
// }
