import 'package:flutter/material.dart';
import 'package:team_dart_knights_sih/core/constants.dart';

import '../../../../../models/User.dart';

class ProfileTile extends StatelessWidget {
  final User user;
  const ProfileTile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      // fit: StackFit.expand,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 40),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(color: blendColor, blurRadius: 15, spreadRadius: 5)
              ],
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        size: 16,
                        color: primaryColor,
                      ))
                ],
              ),
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
