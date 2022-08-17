import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/classroom_card.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/class_details_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloadAttedance extends StatefulWidget {
  DownloadAttedance({Key? key}) : super(key: key);

  @override
  State<DownloadAttedance> createState() => _DownloadAttedanceState();
}

class _DownloadAttedanceState extends State<DownloadAttedance> {
  @override
  Widget build(BuildContext context) {
    final classCubit = BlocProvider.of<ClassDetailsCubit>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          actions: [Container()],
          // backgroundColor: backgroundColor,
          automaticallyImplyLeading: true,
          elevation: 0,
          iconTheme: const IconThemeData(color: blackColor),
          title: const Text(
            'Download Attendance',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: blackColor,
              size: 20,
            ),
          ),
        ),
        body: BlocBuilder<ClassDetailsCubit, ClassDetailsState>(
          builder: (context, state) {
            if (state is ClassDetailsInitial ||
                state is FectingAttendanceByDate) {
              return progressIndicator;
            }

            return Container(
                color: backgroundColor,
                child: Expanded(
                  child: GridView.count(
                      crossAxisCount: 6,
                      children: List.generate(
                          classCubit.classAttendanceListDate!.length,
                          (index) => DownloadTile(
                              classCubit.classAttendanceListDate![index]
                                  .presentPercent
                                  .toString(),
                              classCubit
                                  .classAttendanceListDate![index].teacherEmail
                                  .toString(),
                              () {}))),
                ));
          },
        ));
  }
}

Widget DownloadTile(String precent, String teacher, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
        boxShadow: const [
          BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10)
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today\'s Attendance',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: whiteColor),
          ),
          Text(
            precent,
            style: const TextStyle(
                fontSize: 40,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: whiteColor),
          ),
          const Text(
            'Taken By:-',
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: whiteColor),
          ),
          Text(
            teacher,
            style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: whiteColor),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: onTap,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                    color: navPanecolor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Download CSV',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: blackColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
