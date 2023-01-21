import 'dart:async';

import 'package:chat/constants/color.dart';
import 'package:chat/constants/validation.dart';
import 'package:chat/functions/connection.dart';
import 'package:chat/functions/toast.dart';
import 'package:chat/screens/message/chat_room.dart';
import 'package:chat/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SearchUser extends StatefulWidget {
  SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final TextEditingController controller = TextEditingController();
  late Map<String, dynamic> userMap = {};
  late GlobalKey<FormState> formKeyText = GlobalKey<FormState>();
  List<Map<String, dynamic>> list = [];
  Timer? _timer;
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  chatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b$a";
    } else {
      return "$a$b";
    }
  }

  void onSearch() async {
    try {
      String name = controller.text.toUpperCase().trim();
      if (name.isNotEmpty) {
        if (formKeyText.currentState!.validate()) {
          print(name);
          EasyLoading.show(status: "Loading..");
          FirebaseFirestore _fireStore = FirebaseFirestore.instance;
          // await _fireStore
          //     .collection("users")
          //     .where("lname", isEqualTo: "DEVI")
          //     .get()
          //     .then((value) => {
          //           for (int x = 0; x < value.docs.length; x++)
          //             {print(value.docs[x].data())}
          //         });
          await _fireStore
              .collection("users")
              .where("mname", isEqualTo: name)
              .get()
              .then((value) => {
                    setState(() {
                      for (int x = 0; x < value.docs.length; x++) {
                        print(value.docs[x].data());
                        if (value.docs[x].data()['email'] !=
                            "${_auth.currentUser!.email}") {
                          print(value.docs[x].data());
                          list.add(value.docs[x].data());
                        }
                      }
                      // userMap = value.docs[x].data();
                    })
                  });
          EasyLoading.dismiss();
          print("-------------------------------------------$list");
        }
      } else {
        setState(() {
          list = [];
        });
        print("name Is Empty");
      }
    } catch (e) {
      print(e);
      checkConnection(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Form(
        key: formKeyText,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.deepPurple,
                ),
                child: TextFormField(
                  validator: searchValidator,
                  controller: controller,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey[350]),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            TextButton(
                onPressed: onSearch,
                child: Container(
                  child: Center(
                      child: Text("Enter",
                          style: TextStyle(color: Colors.white, fontSize: 20))),
                  color: Colors.deepPurple,
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.width / 8,
                )),
            list.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                // String chatRoom = chatRoomId(
                                //     '${_auth.currentUser!.email}',
                                //     "${list[index]['email']}");
                                // Navigator.push(context,
                                //     MaterialPageRoute(builder: (context) {
                                //   return ChatRoom(
                                //     chatRoomId: chatRoom,
                                //     user: list[index],
                                //   );
                                // }));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    border: Border.all(color: Colors.black26)),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3.0),
                                      child: Text(
                                        "${list[index]['fname']} ${list[index]['mname']} ${list[index]['lname']}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          bool kill = false;
                                          try {
                                            final fuck = await _fireStore
                                                .collection("users")
                                                .doc(_auth.currentUser!.uid)
                                                .collection("friends")
                                                .get();
                                            for (var x in fuck.docs) {
                                              if (x.data()['friend'] ==
                                                  "${list[index]['email']}") {
                                                kill = true;
                                                break;
                                              } else {
                                                toastMessage(
                                                    "Friend already Added");
                                              }
                                            }
                                            if (!kill) {
                                              await _fireStore
                                                  .collection('users')
                                                  .doc(
                                                      "${_auth.currentUser!.uid}")
                                                  .collection("friends")
                                                  .add({
                                                'friend':
                                                    "${list[index]['email']}",
                                                'name':
                                                    "${list[index]['fname']} ${list[index]['mname']} ${list[index]['lname']}"
                                              });

                                              final test = await _fireStore
                                                  .collection("uids")
                                                  .doc(list[index]['email'])
                                                  .get();
                                              print(test['uid']);
                                              final cu=await _fireStore.collection("users").doc(_auth.currentUser!.uid).get();

                                              await _fireStore
                                                  .collection('users')
                                                  .doc(
                                                  "${test['uid']}")
                                                  .collection("friends")
                                                  .add({
                                                'friend':
                                                "${_auth.currentUser!.email}",
                                                'name':
                                                "${cu.get("fname")} ${cu.get('mname')} ${cu.get("lname")}"
                                              });

                                            } else {
                                              toastMessage(
                                                  "Friend Already Added");
                                            }

                                            //     if()

                                          } catch (e) {
                                            checkConnection(context);
                                          }
                                          // final test = await _fireStore
                                          //     .collection("uids")
                                          //     .doc(list[index]['email'])
                                          //     .get();
                                          // print(test['uid']);
                                          // final cu=await _fireStore.collection("users").doc(_auth.currentUser!.uid).get();
                                          //
                                          //
                                          // String testwe=;
                                          // print(testwe);

                                          // await _fireStore
                                          //     .collection('users')
                                          //     .doc(
                                          //     "${test['uid']}")
                                          //     .collection("friends")
                                          //     .add({
                                          //   'friend':
                                          //   "${_auth.currentUser!.email}",
                                          //   'name':
                                          //   "${cu['fname']} ${cu[index]['mname']} ${cu[index]['lname']}"
                                          // });
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Add ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: darkPurpleColor),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      child: Text(
                        "No User With This Name",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
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
