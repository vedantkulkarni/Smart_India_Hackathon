import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/admin_bloc/admin_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/Backend/aws_api_client.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/cubit/management_cubit.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/manage_classroom.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/manage_teachers_page.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/manage_users_page.dart';
import 'package:team_dart_knights_sih/injection_container.dart';

class ManageMentCard extends StatelessWidget {
  final String addText;
  final String content;
  final String imagePath;
  final int index;
  ManageMentCard(
      {Key? key,
      required this.addText,
      required this.content,
      required this.imagePath,
      required this.index})
      : super(key: key);
  List<ManagementMode> modes = [ManagementMode.User, ManagementMode.Teachers];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) {
            return MultiBlocProvider(providers: [
              BlocProvider.value(value: BlocProvider.of<AdminCubit>(context)),
              BlocProvider(
                  create: (context) => ManagementCubit(
                      awsApiClient: getIt<AWSApiClient>(),
                      managementMode: modes[index])),
            ], child: customPushHandlerFunction(index));
          }));
        },
        child: Container(
            height: 200,
            width: 200,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  height: 50,
                  width: 50,
                  child: Image.asset(imagePath),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  addText,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 18),
                ),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris malesuada eget tortor non efficitur.',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: lightTextColor,
                      fontFamily: 'Poppins',
                      fontSize: 14),
                )
              ],
            )),
      ),
    );
  }

  Widget customPushHandlerFunction(int index) {
    if (index == 0) {
      return const ManageUsers();
    } else if (index == 1) {
      return const MangeTeachersPage();
    } else if (index == 2) {
      return const ManageClassroom();
    } else {
      return Container();
    }
  }
}
