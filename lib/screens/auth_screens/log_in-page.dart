import 'dart:async';

import 'package:chat/constants/color.dart';
import 'package:chat/constants/validation.dart';
import 'package:chat/constants/routes.dart';
import 'package:chat/functions/connection.dart';
import 'package:chat/functions/toast.dart';
import 'package:chat/screens/message/chat.dart';
import 'package:chat/widgets/appbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  late GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();
  Timer? _timer;
  late double _progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width / 4, left: 40, right: 40),
          child: Form(
            key: formKeyLogin,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/signup.png'))),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: borderColor,
                      )),
                      labelStyle: TextStyle(color: Colors.white),
                      label: Text("Enter Your Email"),
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 3, color: borderColor))),
                  validator: EmailValidator(
                      errorText: "Please Enter a Valid Email Address"),
                  controller: emailController,
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 3,
                        color: borderColor,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: borderColor)),
                      labelStyle: TextStyle(color: Colors.white),
                      label: Text("Enter Your Password"),
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder()),
                  validator: passwordValidator,
                  controller: passwordController,
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () async {
                    if (formKeyLogin.currentState!.validate()) {
                      EasyLoading.show(status: "Loading");
                    //  EasyLoading.showProgress(0.3, status: 'downloading...');
                      try {
                        final newUser = await auth.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        print(newUser.user?.email);
                        EasyLoading.dismiss();
                        //print(passwordController.text);
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                           prefs.setBool("isLoggedIn", true);
                        Navigator.pushNamedAndRemoveUntil(context, ScreenRoutes.CHAT_SCREEN, (route) => false);//pushNamed(context, ScreenRoutes.LOGIN_SCREEN);
                      } catch (e) {
                        EasyLoading.dismiss();
                        checkConnection(context);
                        toastMessage("Mail ID Or Password is incorrect");
                        print(e);
                      }
                    } else {
                      print("Form Not Validated");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: authButtonColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.width / 12,
                    child: const Center(
                      child: Text(
                        "Log In",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Text("Or",style: TextStyle(fontSize: 24, color: Colors.white)),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, ScreenRoutes.CREATE_ACCOUNT_SCREEN);
                }, child:  Container(
                  decoration: BoxDecoration(
                    color: authButtonColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 12,
                  child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ))

              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
  //  EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    EasyLoading.dismiss();
    EasyLoading.removeAllCallbacks();
    super.deactivate();

  }
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();

  }

}
