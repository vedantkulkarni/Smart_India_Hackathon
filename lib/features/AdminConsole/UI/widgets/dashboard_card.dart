import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:get/get.dart';

class DashboardCard extends StatelessWidget {
  String user;
  String number;
  Color color;
  DashboardCard(
      {required this.user, required this.number, required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // ScreenUtil.init(context, designSize: Size(width, height));
    return Expanded(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 5)
            ],
            color: backgroundColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Container(
                height: 50.h,
                width: _screenWidth > 800.w ? 50.w : 300.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: color,
                ),
                child: const Center(
                    child: Icon(
                  FluentIcons.admin,
                  color: whiteColor,
                )),
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.tr,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: greyColor,
                        fontFamily: 'Poppins',
                        fontSize: _screenWidth > 800.w ? 14.sp : 24.sp),
                  ),
                  Text(
                    number,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: _screenWidth > 800.w ? 18.sp : 20.sp),
                  )
                ],
              )
            ],
          )),
    );
  }
}

// TODO: Make 