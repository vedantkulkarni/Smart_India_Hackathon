import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/classroom_details.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/class_details_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/injection_container.dart';
import 'package:team_dart_knights_sih/models/ClassRoom.dart';

import '../../../../../core/constants.dart';
import '../../../Backend/admin_bloc/admin_cubit.dart';

class ClassRoomCard extends StatefulWidget {
  final ClassRoom classRoom;
  const ClassRoomCard({Key? key, required this.classRoom}) : super(key: key);

  @override
  State<ClassRoomCard> createState() => _ClassRoomCardState(classRoom);
}

class _ClassRoomCardState extends State<ClassRoomCard> {
  final ClassRoom classRoom;
  _ClassRoomCardState(this.classRoom);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(value: BlocProvider.of<AdminCubit>(context)),
                BlocProvider.value(
                    value: BlocProvider.of<ManagementCubit>(context)),
                BlocProvider(
                    create: (context) => ClassDetailsCubit(
                        classRoomId: classRoom.id,
                        awsApiClient: getIt<AWSApiClient>()))
              ],
              child: ClassRoomDetails(
                classRoom: classRoom,
              ),
            );
          }));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10)
            ],
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 50.h,
                width: 50.w,
                // child: Image.asset(imagePath),
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                classRoom.classRoomName,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 18.sp),
              ),
              Text(
                'Lorem ipsum dolor sit amet',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: lightTextColor,
                    fontFamily: 'Poppins',
                    fontSize: 14.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
