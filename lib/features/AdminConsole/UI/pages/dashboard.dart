import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/admin_console.dart';
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
    return ScaffoldPage(
      padding: const EdgeInsets.all(20),
      header: Container(
        padding: const EdgeInsets.only(left: 30),
        child: const Text(
          "Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      content: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
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
            )
          ],
        ),
      ),
    );
  }
}
