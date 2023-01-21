import 'dart:async';

import 'package:chat/constants/color.dart';
import 'package:chat/constants/validation.dart';
import 'package:chat/constants/routes.dart';
import 'package:chat/functions/connection.dart';
import 'package:chat/functions/toast.dart';
import 'package:chat/screens/auth_screens/log_in-page.dart';
import 'package:chat/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';

class CreateAccount extends StatefulWidget {
  CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final TextEditingController lastController = TextEditingController();

  final TextEditingController firstController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController middleController = TextEditingController();
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String passVal = '';
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
              top: MediaQuery.of(context).size.width / 27, left: 40, right: 40),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/signup.png'))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: borderColor,
                            )),
                            labelStyle: TextStyle(color: Colors.white),
                            label: Text("First Name"),
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: borderColor))),
                        controller: firstController,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextFormField(
                        validator: nameValidator,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: borderColor,
                            )),
                            labelStyle: TextStyle(color: Colors.white),
                            label: Text("Middle Name"),
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: borderColor))),
                        controller: middleController,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: TextFormField(
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: borderColor,
                            )),
                            labelStyle: TextStyle(color: Colors.white),
                            label: Text("Last Name"),
                            contentPadding: EdgeInsets.all(8),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 3, color: borderColor))),
                        controller:lastController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
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
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  onChanged: (pass) => passVal = pass,
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
                const SizedBox(
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
                  validator: (value) =>
                      MatchValidator(errorText: "Password Do Not Match")
                          .validateMatch(value!, passVal),
                  controller: confirmPasswordController,
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      EasyLoading.show(status: "Loading");
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        final storeNameInDataBase = await _fireStore
                            .collection('users')
                            .doc(_auth.currentUser!.uid)
                            .set({
                          "fname": firstController.text.toUpperCase().trim(),
                          "mname": middleController.text.toUpperCase().trim(),
                          "lname": lastController.text.toUpperCase().trim(),
                          "email": _auth.currentUser!.email,
                          // "face":""
                        });

                        await _fireStore.collection("uids").doc("${_auth.currentUser!.email}").set(
                          {
                            "uid":_auth.currentUser!.uid,
                            "email":_auth.currentUser!.email
                          }
                        );

                        //print(newUser.user?.email);
                        //print(passwordController.text);
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            ScreenRoutes.LOGIN_SCREEN,
                            (route) =>
                                false); //pushNamed(context, ScreenRoutes.LOGIN_SCREEN);

                        EasyLoading.dismiss();
                      } catch (e) {
                        EasyLoading.dismiss();
                        checkConnection(context);
                        toastMessage("Account Not Created Please Try Again");
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
                        "Sign Up",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Text("Or",style: TextStyle(fontSize: 24, color: Colors.white)),
                TextButton(onPressed: (){
                  Navigator.pushNamed(context, ScreenRoutes.LOGIN_SCREEN);
                }, child:  Container(
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
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    middleController.dispose();
    firstController.dispose();
    lastController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    EasyLoading.dismiss();
    EasyLoading.removeAllCallbacks();
    super.deactivate();
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
    // EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }
}
