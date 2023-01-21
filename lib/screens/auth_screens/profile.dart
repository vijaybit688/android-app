import 'package:chat/constants/color.dart';
import 'package:chat/constants/routes.dart';
import 'package:chat/functions/connection.dart';
import 'package:chat/functions/toast.dart';
import 'package:chat/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  String name = "";
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "Name: $name",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () async {
                  await _auth.signOut();
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool("isLoggedIn", false);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      ScreenRoutes.FIRST_SCREEN, (route) => false);
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
                      "Log Out",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUserName();
  }

  getCurrentUserName() async {
    try{
      final data = await _fireStore
          .collection("users")
          .doc("${_auth.currentUser!.uid}")
          .get()
          .then((value) => {
                for (int x = 0; x < value.data()!.length; x++)
                  {
                    setState(() {
                      name =
                          "${value['fname']} ${value['mname']} ${value['lname']}";
                    })
                  }
              });
    }
    catch(e){
      checkConnection(context);
      toastMessage("Please LogOut And Login Again Something Went Wrong");
      print(e);
    }
  }
}
