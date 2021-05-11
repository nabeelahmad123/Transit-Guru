import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import 'Tabs/Management.dart';
import 'Tabs/Performance.dart';
import 'Tabs/Performance.dart';
import 'Tabs/Report.dart';

class Mainpage extends StatefulWidget {
  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int currentPage = 1;

  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
              iconData: Icons.folder,
              title: "Reports",
              onclick: () {
                final FancyBottomNavigationState fState = bottomNavigationKey
                    .currentState as FancyBottomNavigationState;
                fState.setPage(1);
              }),
          TabData(
            iconData: Icons.pause,
            title: "Performance",
          ),
          TabData(
            iconData: Icons.settings,
            title: "Management",
          ),
        ],
        initialSelection: 1,
        key: bottomNavigationKey,
        circleColor: Colors.white,
        activeIconColor: Colors.orange,
        inactiveIconColor: Colors.grey[600],
        textColor: Colors.grey[600],
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return REport();
      case 1:
        return Performance();
      default:
        return Management();
    }
  }
}
