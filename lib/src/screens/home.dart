import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:sme/src/pages/home_page.dart';
import 'package:sme/src/pages/profile_page.dart';
import 'package:sme/src/pages/statistics_page.dart';
import 'package:sme/src/widgets/hex_color.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      //Container(),
      const StatisticsScreen(),
      const ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(EvaIcons.home),
        title: ("Home"),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        activeColorPrimary: HexColor('#102d61'),
        activeColorSecondary: HexColor('#ffffff'),
        inactiveColorPrimary: CupertinoColors.black,
        inactiveColorSecondary: Colors.red,
      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        icon: const Icon(EvaIcons.pieChart),
        title: ("Statistics"),
        activeColorPrimary: HexColor('#102d61'),
        activeColorSecondary: HexColor('#ffffff'),
        inactiveColorPrimary: CupertinoColors.black,
      ),
      PersistentBottomNavBarItem(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        icon: const Icon(EvaIcons.person),
        title: ("Profile"),
        activeColorPrimary: HexColor('#102d61'),
        activeColorSecondary: HexColor('#ffffff'),
        inactiveColorPrimary: CupertinoColors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: HexColor('#ffffff'), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeRToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        border: const Border(
            top: BorderSide(
                width: 1, color: Color.fromARGB(255, 228, 228, 228))),
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style10, // Choose the nav bar style with this property.
    );
  }
}
