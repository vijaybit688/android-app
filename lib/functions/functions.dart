import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool getStatusUserLoggedInOrNot(SharedPreferences prefs) {
  bool? isLoggedIn = (prefs.getBool('isLoggedIn') == null)
      ? false
      : prefs.getBool('isLoggedIn');
  return isLoggedIn!;
}

AppBar appBarForChatRoom(String title) {
  return AppBar(
    title: Text(title),
  );
}

