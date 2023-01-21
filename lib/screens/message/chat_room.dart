import 'package:chat/functions/connection.dart';
import 'package:chat/functions/functions.dart';
import 'package:chat/functions/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final scrollController = ScrollController();

class ChatRoom extends StatefulWidget {
  late final String chatRoomId;
  late final Map<String, dynamic> user;
  ChatRoom({Key? key, required this.chatRoomId, required this.user})
      : super(key: key);
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    final FirebaseAuth firebase = FirebaseAuth.instance;
    final size = MediaQuery.of(context).size.width;
    final controller = TextEditingController();
    Widget message(message, sendby) {
      return Row(
        mainAxisAlignment: sendby == "${firebase.currentUser!.email}"
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(40)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    onSend() async {
      _scrollDown();
      try {
        if (controller.text.trim().isNotEmpty) {
          Map<String, dynamic> message = {
            "sendby": "${firebase.currentUser!.email}",
            "message": controller.text,
            'time': FieldValue.serverTimestamp(),
          };
          await _fireStore
              .collection("chatroom")
              .doc(widget.chatRoomId)
              .collection("chats")
              .add(message);
          controller.clear();

          // await _fireStore
          //     .collection("uids")
          //     .doc(widget.user['email'])
          //     .get()
          //     .then((value) async {
          //  print("==============" + value.get("uid"));
          // final me = await _fireStore
          //     .collection("users")
          //     .doc(firebase.currentUser!.uid)
          //     .get();
          // final fuck = await _fireStore
          //     .collection("users")
          //     .doc(value.get('uid'))
          //     .collection("friends")
          //     .get();
          //
          // try{
          //   for (var x in fuck.docs) {
          //     if (x.data()['friend'] != "${firebase.currentUser!.email}") {
          //       await _fireStore
          //           .collection("users")
          //           .doc(value.get('uid'))
          //           .collection("friends")
          //           .add({
          //         "friend": firebase.currentUser!.email,
          //         "name": "${me['fname']} ${me["mname"]} ${me['lname']}"
          //       });
          //       break;
          //     } else {
          //       print("someThing Went wrong");
          //     }
          //   }
          // }catch(e){
          //   await _fireStore
          //       .collection("users")
          //       .doc(value.get('uid'))
          //       .collection("friends")
          //       .add({
          //     "friend": firebase.currentUser!.email,
          //     "name": "${me['fname']} ${me["mname"]} ${me['lname']}"
          //   });
          // }
          // });
          setState(() {});
        } else {
          print("string is empty");
        }
      } catch (e) {
        print(e);
        checkConnection(context);
      }
    }

    return Scaffold(
      appBar: appBarForChatRoom(
          "${widget.user['fname']} ${widget.user['mname']} ${widget.user['lname']}"),
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _fireStore
                  .collection("chatroom")
                  .doc(widget.chatRoomId)
                  .collection("chats")
                  .orderBy('time', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: ListView.builder(
                        controller: scrollController,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return message(snapshot.data!.docs[index]['message'],
                              snapshot.data!.docs[index]['sendby']);
                        }),
                  );
                } else {
                  return Container();
                }
              }),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(30)),
                      width: size / 1.24,
                      child: TextField(
                          maxLines: null,
                          style: TextStyle(color: Colors.white),
                          controller: controller,
                          decoration: InputDecoration(
                              hintText: "Type Here",
                              hintStyle: TextStyle(color: Colors.grey[350]),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)))),
                    ),
                  ),
                  IconButton(
                      onPressed: onSend,
                      icon: Icon(
                        Icons.send,
                        size: 28,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }
}
