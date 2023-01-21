import 'package:chat/functions/connection.dart';
import 'package:chat/widgets/appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat_room.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final fireStore = FirebaseFirestore.instance;
    Map<String, dynamic> user = {};
    return Scaffold(
      appBar: appbar,
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStore
            .collection("users")
            .doc("${_auth.currentUser!.uid}")
            .collection("friends")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            border: Border.all(color: Colors.black26)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () async {
                                  try{
                                    await fireStore
                                        .collection("users")
                                        .where("email",
                                            isEqualTo:
                                                "${snapshot.data!.docs[index]['friend']}")
                                        .get()
                                        .then((value) {
                                      for (var x in value.docs) {
                                        user = x.data();
                                      }
                                      String chatRoom = chatRoomId(
                                          '${_auth.currentUser!.email}',
                                          "${snapshot.data!.docs[index]['friend']}");
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return ChatRoom(
                                          chatRoomId: chatRoom,
                                          user: user,
                                        );
                                      }));
                                    });
                                  }catch(e){
                                    print(e);
                                    checkConnection(context);
                                  }
                                },
                                child: Text(
                                  snapshot.data!.docs[index]['name'],
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              )
                            ],
                          ),
                        )),
                  );
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }

  String chatRoomId(String user1, String user2) {
    String email1=user1;
    String email2=user2;
    if(user1[0].toLowerCase().codeUnits[0] ==
        user2[0].toLowerCase().codeUnits[0]){
      String another1 = user1.split('@')[0];
      String another2 = user2.split('@')[0];

      List listuser1 = another1.split('');
      List listuser2 = another2.split('');
      String user1111 = removefor1(listuser1, listuser2);

      String another11 = user1.split('@')[0];
      String another22 = user2.split('@')[0];

      List listuser11 = another11.split('');
      List listuser22 = another22.split('');
      String user2222= removefor2(listuser11, listuser22);

      if(user1111[0].toLowerCase().codeUnits[0]>user2222[0].toLowerCase().codeUnits[0]){
        return "$email1$email2";
      }
      else{
        return "$email2$email1";
      }
    }else
    if (user1[0].toLowerCase().codeUnits[0] >
        user2[0].toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }

  }
  String removefor1(List listuser1, List listuser2) {
    listuser1.removeWhere((element) => listuser2.contains(element));
    return(listuser1.join());
  }

  String removefor2(List listuser1, List listuser2) {
    listuser2.removeWhere((element) => listuser1.contains(element));
    return(listuser2.join());
  }

}
//
