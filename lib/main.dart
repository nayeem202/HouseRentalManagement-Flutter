import 'package:client_mobile/ep882_house_rental_app/house_rental_app.dart';
import 'package:client_mobile/ep882_house_rental_app/ui/house_rental_home_page.dart';
import 'package:client_mobile/views/login/login.dart';
import 'package:client_mobile/views/login/login_page.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return _MyApp();
  }
}

class _MyApp extends State {
  Widget? _child;

  @override
  void initState() {
    _child = HouseRentalApp();
    super.initState();
  }

  @override
  Widget build(context) {
    // Build a simple container that switches content based of off the selected navigation item
    return MaterialApp(
      //theme: ThemeData(primarySwatch: Colors.red),
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        backgroundColor: Color(0xFF920152),
        extendBody: true,
        body: _child,
        bottomNavigationBar: FluidNavBar(
          icons: [
            FluidNavBarIcon(
                icon: Icons.menu,
                extras: {"label": "Category"}),
            FluidNavBarIcon(
                icon: Icons.home,
                extras: {"label": "Home"}),
            FluidNavBarIcon(
                icon: Icons.person,
                extras: {"label": "Profile"}),
          ],
          onChange: _handleNavigationChange,
          style: FluidNavBarStyle(
              barBackgroundColor: Colors.deepPurpleAccent,
              iconSelectedForegroundColor: Colors.white,
              iconUnselectedForegroundColor: Colors.white70),
          scaleFactor: 1.5,
          defaultIndex: 0,
          itemBuilder: (icon, item) => Semantics(
            label: icon.extras!["label"],
            child: item,
          ),
        ),
      ),
    );
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = const LoginPage();
          break;
        case 1:
          _child = HouseRentalHomePage();
          break;
        case 2:
          _child = Login();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: Duration(milliseconds: 500),
        child: _child,
      );
    });
  }
}