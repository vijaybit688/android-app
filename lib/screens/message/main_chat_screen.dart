import 'package:chat/constants/color.dart';
import 'package:chat/functions/functions.dart';
import 'package:chat/screens/auth_screens/app_first_screen.dart';

import 'package:chat/screens/auth_screens/profile.dart';
import 'package:chat/screens/message/chat.dart';
import 'package:chat/screens/message/searrch_users.dart';
import 'package:chat/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../functions/category.dart';
import '../counselling.dart';
import '../videos_category.dart';

class MainChatScreen extends StatefulWidget {
  MainChatScreen({Key? key, required this.prefs}) : super(key: key);
  final SharedPreferences prefs;
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<MainChatScreen> {
  int pageIndex = 0;
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = getStatusUserLoggedInOrNot(widget.prefs);
    return isLoggedIn
        ? Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: appBarColor,
              selectedItemColor: Colors.white,
              iconSize: 24,
              unselectedItemColor: Colors.grey,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.speaker), label: "Speech"),
               // BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
               //  BottomNavigationBarItem(
               //      icon: Icon(Icons.search), label: "Search User"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.perm_media_sharp), label: "Videos"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_rounded), label: "Profile"),
              ],
              onTap: navigationBarFunction,
              currentIndex: pageIndex,
            ),
            body: PageView(
              controller: pageController,
              onPageChanged: pageViewFunction,
              children: [
                OnlineCounseling(),
                // ChatScreen(),
                // SearchUser(),
                VideoScreen(),
                ProfilePage(),
              ],
            ))
        : FirstScreen(
            prefs: widget.prefs,
          );
  }

  void navigationBarFunction(int value) {
    pageController.animateToPage(value,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void pageViewFunction(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
