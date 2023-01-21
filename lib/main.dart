import 'package:chat/constants/color.dart';
import 'package:chat/screens/auth_screens/app_first_screen.dart';
import 'package:chat/screens/message/chat.dart';
import 'package:chat/screens/auth_screens/log_in-page.dart';
import 'package:chat/screens/auth_screens/create_account_page.dart';
import 'package:chat/screens/auth_screens/profile.dart';
import 'package:chat/screens/message/chat_room.dart';
import 'package:chat/screens/message/main_chat_screen.dart';
import 'package:chat/screens/message/searrch_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/routes.dart';

bool isWhite = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
  configLoading();
}
// void main(){
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ChatRoom(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  MyApp({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        routes: {
          ScreenRoutes.FIRST_SCREEN: (context) => FirstScreen(
                prefs: prefs,
              ),
          ScreenRoutes.LOGIN_SCREEN: (context) => LogInPage(),
          ScreenRoutes.CREATE_ACCOUNT_SCREEN: (context) => CreateAccount(),
          ScreenRoutes.AUTH_CHAT_SCREEN: (context) => ChatScreen(),
          ScreenRoutes.PROFILE: (context) => ProfilePage(),
          ScreenRoutes.SEARCH_USER: (context) => SearchUser(),

          ScreenRoutes.CHAT_SCREEN: (context) => MainChatScreen(
                prefs: prefs,
              )
        },
        builder: EasyLoading.init(),
        title: 'Counselling',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: appBarColor,
          ),
          scaffoldBackgroundColor: scaffoldBackgroundColor,
        ));
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true;
}
