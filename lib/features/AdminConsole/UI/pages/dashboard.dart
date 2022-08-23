import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image/image.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/chart/cartesianChart.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/chart/pieChart.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/dashboard_card.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final adminProvider = BlocProvider.of<AdminCubit>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // ScreenUtil.init(context, designSize: Size(width, height));
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "hi".tr,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 44.sp,
                fontFamily: 'Poppins',
                color: primaryColor),
          ),
          Text(
            "${adminProvider.admin.name},",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 44.sp,
                fontFamily: 'Poppins',
                color: blackColor),
          ),
          SizedBox(
            height: 60.h,
          ),
          Text(
            "DashBoard".tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                fontFamily: 'Poppins',
                color: blackColor),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const PieChartWidget();
                  }));
                },
                child: DashboardCard(
                  user: 'Students',
                  number: '302',
                  color: primaryColor,
                ),
              ),
              DashboardCard(
                user: 'Teachers',
                number: '33',
                color: secondaryColor,
              ),
              DashboardCard(user: 'Staff', number: '28', color: yellowColor),
            ],
          ),
          Expanded(child: Cartesian()),
        ],
      ),
    );
  }
}
