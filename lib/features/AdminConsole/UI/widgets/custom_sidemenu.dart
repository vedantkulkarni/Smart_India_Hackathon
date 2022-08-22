import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../core/constants.dart';

class CustomSideMenu extends StatefulWidget {
  PageController page;
  CustomSideMenu({Key? key, required this.page}) : super(key: key);

  @override
  State<CustomSideMenu> createState() => _CustomSideMenuState(page);
}

class _CustomSideMenuState extends State<CustomSideMenu> {
  PageController page;
  _CustomSideMenuState(this.page);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // ScreenUtil.init(context, designSize: Size(width, height));
    List<SideMenuItem> items = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,

        title: width > 300 ? 'Dashboard'.tr : '',

        onTap: () => page.jumpToPage(0),
        icon: const Icon(FluentIcons.home),
      ),
      SideMenuItem(
        priority: 1,
        title: width > 300 ? 'Attendance'.tr : '',
        onTap: () => page.jumpToPage(1),
        icon: const Icon(FluentIcons.check_list),
      ),
      SideMenuItem(
        priority: 2,
        title: width > 300 ? 'Manage'.tr : '',
        onTap: () => page.jumpToPage(2),
        icon: const Icon(FluentIcons.add_group),
      ),
      SideMenuItem(
        priority: 3,
        title: width > 300 ? 'Settings'.tr : '',
        onTap: () => page.jumpToPage(3),
        icon: const Icon(FluentIcons.settings),
      ),
      SideMenuItem(
        priority: 4,
        title: width > 300 ? 'Log Out' : '',
        onTap: () {},
        icon: const Icon(FluentIcons.sign_out),
      ),
    ];
    return Container(
      child: SideMenu(
        // Page controller to manage a PageView
        controller: page,
        // Will shows on top of all items, it can be a logo or a Title text
        title: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Image.asset(
              'assets/images/class.png',
              width: 60.w,
              height: 60.h,
            ),
            SizedBox(
              height: 40.h,
            )
          ],
        ),
        // Will show on bottom of SideMenu when displayMode was SideMenuDisplayMode.open
        footer: const Text('demo'),
        // Notify when display mode changed
        onDisplayModeChanged: (mode) {},
        // List of SideMenuItem to show them on SideMenu
        items: items,
        style: SideMenuStyle(
          displayMode: SideMenuDisplayMode.auto,
          openSideMenuWidth: 300,
          compactSideMenuWidth: 40,
          hoverColor: secondaryColor.withOpacity(0.1),
          selectedColor: navPanecolor,
          selectedIconColor: primaryColor,
          unselectedIconColor: lightTextColor,
          backgroundColor: navPanecolor,
          selectedTitleTextStyle: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              fontFamily: 'Poppins'),
          unselectedTitleTextStyle: TextStyle(
              color: lightTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              fontFamily: 'Poppins'),
          iconSize: 20,
        ),
      ),
    );
  }
}
