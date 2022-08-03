import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:fluent_ui/fluent_ui.dart';

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
    List<SideMenuItem> items = [
      SideMenuItem(
        // Priority of item to show on SideMenu, lower value is displayed at the top
        priority: 0,

        title: 'Dashboard',
        onTap: () => page.jumpToPage(0),
        icon: const Icon(FluentIcons.home),
      ),
      SideMenuItem(
        priority: 1,
        title: 'Attendance',
        onTap: () => page.jumpToPage(1),
        icon: const Icon(FluentIcons.check_list),
      ),
     
      SideMenuItem(
        priority: 2,
        title: 'Manage',
        onTap: () => page.jumpToPage(2),
        icon: const Icon(FluentIcons.add_group),
      ),
      SideMenuItem(
        priority: 3,
        title: 'Settings',
        onTap: () => page.jumpToPage(3),
        icon: const Icon(FluentIcons.settings),
      ),
      SideMenuItem(
        priority: 4,
        title: 'Log Out',
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
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              'assets/images/class.png',
              width: 60,
              height: 60,
            ),
            const SizedBox(
              height: 40,
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
          selectedTitleTextStyle: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Poppins'),
          unselectedTitleTextStyle: const TextStyle(
              color: lightTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Poppins'),
          iconSize: 20,
        ),
      ),
    );
  }
}
