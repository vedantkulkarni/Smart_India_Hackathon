import 'package:fluent_ui/fluent_ui.dart' as fi;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/csvConvertor.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/class_details_cubit.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_dialog_box.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_textbutton.dart';

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
          title: Text(
            'Download Attendance',
            style: TextStyle(
              fontSize: 14.sp,
              color: blackColor,
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
                      crossAxisCount: 5,
                      children: List.generate(
                          classCubit.classAttendanceListDate!.length,
                          (index) => DownloadTile(
                                  classCubit.classAttendanceListDate![index]
                                      .presentPercent
                                      .toString(),
                                  classCubit.classAttendanceListDate![index]
                                      .teacherEmail
                                      .toString(), () async {
                                // save();
                                classCubit.getAttendanceListOfDate(
                                    classRoomID: classCubit.classRoom.id,
                                    date: classCubit
                                        .classAttendanceListDate![index].date
                                        .toString());
                                await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return BlocProvider.value(
                                      value: classCubit,
                                      child: CustomDialogBox(
                                          widget: DownloadCsvDialog()),
                                    );
                                  },
                                );
                                // showDateRangePicker(context: context, firstDate: firstDate, lastDate: lastDate)
                                fi.showSnackbar(
                                    context,
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: primaryColor,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'The is successfully downloaded',
                                            style: TextStyle(
                                              color: whiteColor,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ));
                              }))),
                ));
          },
        ));
  }
}

Widget DownloadTile(String precent, String teacher, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      //padding: const EdgeInsets.all(10),
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
          Text(
            'Today\'s Attendance',
            style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: whiteColor),
          ),
          Text(
            precent,
            style: TextStyle(
                fontSize: 40.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: whiteColor),
          ),
          Text(
            'Taken By:-',
            style: TextStyle(
                fontSize: 14.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.normal,
                color: whiteColor),
          ),
          Text(
            teacher,
            style: TextStyle(
                fontSize: 15.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: whiteColor),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: onTap,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                    color: navPanecolor,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Download CSV',
                    style: TextStyle(
                        fontSize: 15.sp,
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

class DownloadCsvDialog extends StatefulWidget {
  DownloadCsvDialog({Key? key}) : super(key: key);

  @override
  State<DownloadCsvDialog> createState() => DownloadCsvDialogState();
}

class DownloadCsvDialogState extends State<DownloadCsvDialog> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClassDetailsCubit, ClassDetailsState>(
      builder: (context, state) {
        if (state is ClassDetailsInitial || state is FetchingAttendanceList) {
          return progressIndicator;
        }
        return Container(
            child: Container(
          child: Center(
              child: CustomTextButton(
                  onPressed: () {
                    save(
                        attendanceList:
                            BlocProvider.of<ClassDetailsCubit>(context)
                                .attendanceList);
                  },
                  text: 'Download')),
        ));
      },
    );
  }
}
