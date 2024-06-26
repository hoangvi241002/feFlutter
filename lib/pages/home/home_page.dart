import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khoaluan_flutter/pages/account/account_page.dart';
import 'package:khoaluan_flutter/pages/auth/sign_in_page.dart';
import 'package:khoaluan_flutter/pages/auth/sign_up_page.dart';
import 'package:khoaluan_flutter/pages/cart/cart_history.dart';
import 'package:khoaluan_flutter/pages/order/order_page.dart';
import 'package:khoaluan_flutter/utils/colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'main_medical_item_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PersistentTabController _controller;

  List pages = [
    MainMedicalItemPage(),
    Container(child: Center(child: Text("Next 1 Page")),),
    Container(child: Center(child: Text("Next 2 Page")),),
    Container(child: Center(child: Text("Next 3 Page")),)
  ];

  void onTapNav(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState(){
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      MainMedicalItemPage(),
      OrderPage(),
      CartHistory(),
      AccountPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.main_Color,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.archivebox_fill),
        title: ("Archive"),
        activeColorPrimary: AppColors.main_Color,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.cart_fill),
        title: ("Cart"),
        activeColorPrimary: AppColors.main_Color,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.person),
        title: ("Me"),
        activeColorPrimary: AppColors.main_Color,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
