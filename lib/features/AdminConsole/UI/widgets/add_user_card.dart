import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/widgets/add_user_form.dart';
import 'package:team_dart_knights_sih/models/ModelProvider.dart';

class AddUserCard extends StatelessWidget {
  final String addText;
  final String content;
  final String imagePath;
  const AddUserCard(
      {Key? key,
      required this.addText,
      required this.content,
      required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => const AddUserForm(
                    role: Role.SuperAdmin,
                  ))));
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
}
