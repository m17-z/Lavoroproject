// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
  padding: EdgeInsets.only(left: 2,bottom: 1,right: 1,top: 2),
      color: Colors.purple,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12),
        child: GNav(
          tabBorderRadius: 24,
          backgroundColor: Colors.purple,
          hoverColor: Colors.white,
          color: Colors.black,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.purpleAccent,
          padding: const EdgeInsets.all(16),
          gap: 8,
          selectedIndex: selectedIndex,
          onTabChange: onTabChange,
          tabs: [
            const GButton(
               icon: Icons.cabin,
              text: "Companys",
            ),
            const GButton(
              icon: FontAwesomeIcons.briefcase,
              text: "Jobs",
            ),
            const GButton(
              icon: FontAwesomeIcons.user,
              text: "Profile Page",
            ),
            const GButton(
              icon: FontAwesomeIcons.users,
              text: "Employees",
            ),
          ],
        ),
      ),
    );
  }
}
