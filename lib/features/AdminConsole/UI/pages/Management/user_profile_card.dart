import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_side_sheet/modal_side_sheet.dart';
import 'package:team_dart_knights_sih/core/constants.dart';
import 'package:team_dart_knights_sih/features/AdminConsole/UI/pages/Management/view_and_edit_user.dart';

import '../../../../../models/User.dart';
import 'cubit/management_cubit.dart';

class ProfileTile extends StatelessWidget {
  final User user;
  const ProfileTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          final res = await showModalSideSheet<bool>(
              width: MediaQuery.of(context).size.width * 0.4,
              context: context,
              ignoreAppBar: false,
              body: BlocProvider.value(
                value: BlocProvider.of<ManagementCubit>(context),
                child: ViewAndEditUser(
                  user: user,
                ),
              ));
        },
        child: Stack(
          clipBehavior: Clip.none,
          // fit: StackFit.expand,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: blendColor, blurRadius: 15, spreadRadius: 5)
                  ],
                  color: backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  const Spacer(),
                  Text(user.name,
                      style: const TextStyle(
                          color: blackColor,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold)),
                  Text(user.role.name.toString(),
                      style: const TextStyle(
                          color: primaryColor, fontFamily: 'Poppins')),
                  Container(
                    decoration: const BoxDecoration(
                      color: textFieldFillColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        RowTile(
                            const Icon(
                              Icons.location_city,
                              size: 15,
                            ),
                            'Email',
                            user.email.toString()),
                        RowTile(
                            const Icon(
                              Icons.mail,
                              size: 15,
                            ),
                            'Email',
                            user.email.toString()),
                        RowTile(
                            const Icon(
                              Icons.phone,
                              size: 15,
                            ),
                            'Phone',
                            user.phoneNumber.toString()),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: greyColor.withOpacity(0.8),
                          blurRadius: 15,
                          spreadRadius: 5,
                          offset: const Offset(0, 15))
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://images.pexels.com/photos/220453/pexels-photo-220453"
                            ".jpeg?auto=compress&cs=tinysrgb&w=600"),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RowTile extends StatelessWidget {
  final String text;
  final Icon icon;
  final String place;
  const RowTile(
    this.icon,
    this.text,
    this.place, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(color: blackColor, fontFamily: 'Poppins'),
          ),
          const Spacer(),
          Text(
            place,
            style: const TextStyle(
                color: lightTextColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w100),
          ),
        ],
      ),
    );
  }
}
