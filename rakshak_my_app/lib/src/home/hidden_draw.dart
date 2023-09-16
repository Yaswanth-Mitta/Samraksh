import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
import 'package:rakshak_my_app/src/sidebarpages/add_email.dart';
import 'package:rakshak_my_app/src/sidebarpages/profile.dart';

import 'home_screen.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  final myTextStylebase = GoogleFonts.k2d(
      // textStyle: Theme.of(context).textTheme.bodyMedium,
      fontWeight: FontWeight.normal,
      fontSize: 20,
      color: Colors.black);

  // final mySelectedText
  final selectedTextStyle = GoogleFonts.k2d(
      // textStyle: Theme.of(context).textTheme.bodyMedium,
      fontWeight: FontWeight.normal,
      fontSize: 22,
      color: Colors.white);

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Home",
              baseStyle: myTextStylebase,
              selectedStyle: selectedTextStyle,
              colorLineSelected: Colors.white),
          const HomeScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Profile",
              baseStyle: myTextStylebase,
              selectedStyle: selectedTextStyle,
              colorLineSelected: Colors.white),
          const ProfileScreen()),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: "Add Emergency Email",
              baseStyle: myTextStylebase,
              selectedStyle: selectedTextStyle,
              colorLineSelected: Colors.white),
          const AddEmergencyEmailsScreen()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: Colors.deepPurpleAccent.shade100,
      initPositionSelected: 0,
      slidePercent: 60,
      // isDraggable: true,
      isTitleCentered: true,
    );
  }
}
