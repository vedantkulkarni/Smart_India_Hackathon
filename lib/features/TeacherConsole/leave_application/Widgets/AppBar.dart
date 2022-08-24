import 'package:flutter/material.dart';

import '../../../../core/constants.dart';

class CommonAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool menuenabled;
  final bool notificationenabled;

  const CommonAppBar({
    Key? key,
    required this.title,
    required this.menuenabled,
    required this.notificationenabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: const TextStyle(
              color: primaryColor, fontFamily: 'Poppins', fontSize: 18)),
      automaticallyImplyLeading: true,
      iconTheme: const IconThemeData(
        color: primaryColor,
      ),
      // leading: menuenabled == true
      //     ? IconButton(
      //         color: Colors.black,
      //         onPressed: ontap,
      //         icon: Icon(
      //           Icons.menu,
      //         ),
      //       )
      //     : null,
      actions: [
        notificationenabled == true
            ? InkWell(
                onTap: () {},
                child: Image.asset(
                  "assets/notification.png",
                  width: 35,
                ),
              )
            : const SizedBox(
                width: 1,
              ),
      ],
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
