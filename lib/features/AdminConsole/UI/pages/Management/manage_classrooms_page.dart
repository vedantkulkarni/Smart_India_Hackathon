import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/classroom_card.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/custom_dialog_box.dart';
import 'package:get/get.dart';
import '../../../../../core/constants.dart';
import '../../../../../injection_container.dart';
import '../../../Backend/admin_bloc/admin_cubit.dart';
import '../../../Backend/aws_api_client.dart';
import '../../widgets/create_classroom.dart';
import '../../widgets/custom_textbutton.dart';
import '../../widgets/custom_textfield.dart';

class ManageClassroom extends StatefulWidget {
  const ManageClassroom({Key? key}) : super(key: key);

  @override
  State<ManageClassroom> createState() => _ManageClassroomState();
}

class _ManageClassroomState extends State<ManageClassroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Container()],
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: blackColor),
      ),
      // body: Container(
      //     child: Center(
      //   child: CustomTextButton(
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(
      //             builder: (_) => BlocProvider.value(
      //                   value: BlocProvider.of<AdminCubit>(context),
      //                   child: CreateClassRoom(),
      //                 )));
      //       },
      //       text: 'Create Class Room'),
      // ))

      body: BlocBuilder<ManagementCubit, ManagementState>(
        buildWhen: (previous, current) {
          return (current is! FetchingStudentDetails);
        },
        builder: (context, state) {
          if (state is ManagementInitial || state is FetchingClassRooms) {
            return progressIndicator;
          }

          return Container(
              color: backgroundColor,
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Text('Show'.tr,
                              style: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Poppins',
                                  fontSize: 14.sp)),
                          SizedBox(
                            width: 10.w,
                          ),
                          DropdownButton<int>(
                            icon: null,
                            iconSize: 14,
                            elevation: 4,
                            alignment: Alignment.center,
                            underline: Container(),
                            borderRadius: BorderRadius.circular(10),
                            value: 10,
                            onChanged: (value) {},
                            items: [
                              DropdownMenuItem(
                                child: Text('10',
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: 'Poppins',
                                        fontSize: 14.sp)),
                                value: 10,
                              ),
                              DropdownMenuItem(
                                  child: Text('20',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 14.sp)),
                                  value: 20),
                              DropdownMenuItem(
                                  child: Text('30',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontFamily: 'Poppins',
                                          fontSize: 14.sp)),
                                  value: 30)
                            ],
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          const Spacer(),
                          CustomTextButton(
                              onPressed: () async {
                                final classRoom = await showDialog(
                                  context: context,
                                  builder: (_) {
                                    return MultiBlocProvider(
                                        providers: [
                                          BlocProvider.value(
                                              value:
                                                  BlocProvider.of<AdminCubit>(
                                                      context)),
                                          BlocProvider(
                                              create: (context) =>
                                                  ManagementCubit(
                                                      awsApiClient:
                                                          getIt<AWSApiClient>(),
                                                      managementMode:
                                                          ManagementMode
                                                              .Teachers)),
                                        ],
                                        child: CustomDialogBox(
                                            widget: const CreateClassRoom()));
                                  },
                                );

                                if (classRoom != null) {
                                  await BlocProvider.of<ManagementCubit>(
                                          context)
                                      .getAllClassRooms(limit: 10);
                                }
                              },
                              text: 'Add'.tr + 'Classroom'.tr),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: CustomTextField(
                              hintText: 'Search'.tr,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 20.h),
                              width: 300.w,
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    child: Container(
                      child: GridView.count(
                          crossAxisCount: 6,
                          children: List.generate(
                              (state as ClassRoomsFetched).classroomList.length,
                              (index) => ClassRoomCard(
                                    classRoom: (state).classroomList[index],
                                  ))),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
