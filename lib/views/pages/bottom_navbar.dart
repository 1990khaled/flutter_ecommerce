import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/views/pages/cart_page.dart';
import 'package:flutter_ecommerce/views/pages/home_page.dart';
import 'package:flutter_ecommerce/views/pages/profle_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'accessories.dart';
import 'favorite.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final _bottomNavbarController = PersistentTabController();

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const AccessoriesScreen(),
      const Favorite(),
      const CartPage(),
      const ProfilePage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("الصفحة الرئيسية"),
        activeColorPrimary: const Color(0xFF1B4571),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.folder_solid),
        title: ("اكسسوارات"),
        activeColorPrimary: const Color(0xFF1B4571),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        title: ("المفضلة"),
        activeColorPrimary: const Color(0xFF1B4571),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart),
        title: ("الطلبية"),
        activeColorPrimary: const Color(0xFF1B4571),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("الملف الشخصي"),
        activeColorPrimary: const Color(0xFF1B4571),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _bottomNavbarController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        // backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        // decoration: NavBarDecoration(
        //   borderRadius: BorderRadius.circular(10.0),
        // ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 150),
          curve: Curves.elasticInOut,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,

          curve: Curves.easeIn,
          duration: Duration(milliseconds: 240),
        ),
        navBarStyle:
            NavBarStyle.style2, // Choose the nav bar style with this property.
      ),
    );
  }
}
