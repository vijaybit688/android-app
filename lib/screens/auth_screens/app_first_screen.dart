import 'package:chat/constants/color.dart';
import 'package:chat/constants/routes.dart';
import 'package:chat/functions/functions.dart';
import 'package:chat/screens/message/chat.dart';
import 'package:chat/screens/message/main_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
   FirstScreen({Key? key, required this.prefs}) : super(key: key);
   final SharedPreferences prefs;
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = getStatusUserLoggedInOrNot(widget.prefs);
    return isLoggedIn?MainChatScreen(prefs: widget.prefs):Scaffold(
      body: Padding(
        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width/2.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width/1.5,
              decoration: BoxDecoration(
                  image:DecorationImage(
                      image: AssetImage('images/a.png')
                  )
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: MediaQuery.of(context).size.width/7),
              child: TextButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, ScreenRoutes.LOGIN_SCREEN, (route) => false);//pushNamed(context, ScreenRoutes.LOGIN_SCREEN);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: authButtonColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.width / 10.1,
                  child: const Center(
                    child: Text(
                      "Log In",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 25),
              child: TextButton(
                onPressed: (){
                  Navigator.pushNamedAndRemoveUntil(context, ScreenRoutes.CREATE_ACCOUNT_SCREEN, (route) => false);//pushNamed(context, ScreenRoutes.LOGIN_SCREEN);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: authButtonColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.width / 10.1,
                  child:  const Center(
                    child: Text(
                      "Create Account",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
