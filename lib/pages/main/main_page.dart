// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transportation/components/bottom_navigation_item.dart';
import 'package:transportation/config/app_icons.dart';
import 'package:transportation/pages/driver_trips/driver_trips_page.dart';
import 'package:transportation/pages/home/home_page.dart';
import 'package:transportation/pages/profile/profile_page.dart';
import 'package:transportation/pages/user_bookings/user_bookings_page.dart';
import 'package:transportation/styles/app_colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

int currentindex = Menus.home.index;

class _MainPageState extends State<MainPage> {
  int _userID = 0;

  @override
  void initState() {
    super.initState();
    loadFullName();
  }

  Future<void> loadFullName() async {
    final prefs = await SharedPreferences.getInstance();
    final userid = prefs.getInt('userId');

    setState(() {
      _userID = userid ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_userID == 0) return Center(child: CircularProgressIndicator());
    final pages = [
      HomePage(),
      UserBookingsPage(userId: _userID),
      DriverTripsPage(driverId: _userID), // Replace with actual user ID
      EditProfilePage(),
    ];
    return Scaffold(
      extendBody: true,
      body: pages[currentindex],

      bottomNavigationBar: BottomNavigation(
        // currentIndex: currentindex.index,
        onTap: (value) {
          setState(() {
            currentindex = value.index;
          });
        },
      ),
    );
  }

  // final pages = [
  //   HomePage(),
  //   UserBookingsPage(userId: _userID ), // Replace with actual user ID
  //   Center(child: Text("fav")),
  //   Center(child: Text("message")),
  //   Center(child: Text("message")),
  // ];
}

enum Menus { home, archive, bus, user }

class BottomNavigation extends StatelessWidget {
  final ValueChanged<Menus> onTap;
  const BottomNavigation({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      margin: EdgeInsets.all(24),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 17,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.lightOrange,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: BottomNavigationItem(
                      onPressed: () => onTap(Menus.home),
                      icon: AppIcons.ic_home,
                      index: Menus.home.index,
                    ),
                  ),
                  Expanded(
                    child: BottomNavigationItem(
                      onPressed: () => onTap(Menus.archive),
                      icon: AppIcons.ic_archive,
                      index: Menus.archive.index,
                    ),
                  ),

                  Expanded(
                    child: BottomNavigationItem(
                      onPressed: () => onTap(Menus.bus),
                      icon: AppIcons.ic_bus,
                      index: Menus.bus.index,
                    ),
                  ),
                  Expanded(
                    child: BottomNavigationItem(
                      onPressed: () => onTap(Menus.user),
                      icon: AppIcons.ic_user,
                      index: Menus.user.index,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
