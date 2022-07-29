import 'package:fluent_ui/fluent_ui.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

class DashboardCard extends StatelessWidget {
  String user;
  String number;
  Color color;
  DashboardCard(
      {required this.user, required this.number, required this.color, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                height: 50,
                width: 50,
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
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        color: greyColor,
                        fontFamily: 'Poppins',
                        fontSize: 14),
                  ),
                  Text(
                    number,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                        fontSize: 18),
                  )
                ],
              )
            ],
          )),
    );
  }
}
