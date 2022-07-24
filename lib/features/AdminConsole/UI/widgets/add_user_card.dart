import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/attendance.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/add_user_form.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

class AddUserCard extends StatelessWidget {
  const AddUserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: ((context) => AddUserForm(role: Role.SuperAdmin,))));
        },
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 10)
              ],
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: secondaryColor),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Students',
                      style: TextStyle(
                          color: greyColor, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      'Add',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
