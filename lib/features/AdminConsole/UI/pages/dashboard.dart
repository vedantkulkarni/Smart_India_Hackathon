import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/dashboard_card.dart';

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
            "Hi!",
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
                color: Colors.black),
          ),
          SizedBox(
            height: 60.h,
          ),
          Text(
            "DashBoard",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
                fontFamily: 'Poppins',
                color: Colors.black),
          ),
          SizedBox(
            height: 20.h,
          ),
          _screenWidth > 800.w
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DashboardCard(
                      user: 'Students',
                      number: '302',
                      color: primaryColor,
                    ),
                    DashboardCard(
                      user: 'Teachers',
                      number: '33',
                      color: secondaryColor,
                    ),
                    DashboardCard(
                      user: 'Staff',
                      number: '28',
                      color: Colors.yellow,
                    ),
                  ],
                )
              : SizedBox(
                height: 500.h,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DashboardCard(
                        user: 'Students',
                        number: '302',
                        color: primaryColor,
                      ),
                      DashboardCard(
                        user: 'Teachers',
                        number: '33',
                        color: secondaryColor,
                      ),
                      DashboardCard(
                        user: 'Staff',
                        number: '28',
                        color: Colors.yellow,
                      ),
                    ],
                  ),
              ),
        ],
      ),
    );
  }
}
