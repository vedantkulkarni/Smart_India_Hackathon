import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
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
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "hello".tr,
            style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 44,
                fontFamily: 'Poppins',
                color: primaryColor),
          ),
          Text(
            "${adminProvider.admin.name},",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 44,
                fontFamily: 'Poppins',
                color: Colors.black),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            "DashBoard",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                fontFamily: 'Poppins',
                color: Colors.black),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
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
          // GestureDetector(
          //   onTap: () {
          //     var locale = Locale('hi', 'IN');
          //     Get.updateLocale(locale);
          //   },
          //   child: Container(
          //     height: 60,
          //     width: 100,
          //     color: Colors.red,
          //     child: Text(
          //       'Change',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
