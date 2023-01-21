import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import '../constants/color.dart';
import '../constants/colors.dart';
import '../widgets/appbar.dart';
import 'package:http/http.dart' as http;

import 'message/predicted_value.dart';

String textShow = "";

class OnlineCounseling extends StatefulWidget {
  const OnlineCounseling({Key? key}) : super(key: key);

  @override
  State<OnlineCounseling> createState() => _OnlineCounselingState();
}

class _OnlineCounselingState extends State<OnlineCounseling> {
  String selectedValue1 = 'Select';
  String selectedValue2 = 'Select';
  String selectedValue3 = 'Select';
  String selectedValue4 = 'Select';
  String selectedValue5 = 'Select';
  String selectedValue6 = 'Select';
  String selectedValue7 = 'Select';
  String selectedValue8 = 'Select';
  String selectedValue9 = 'Select';
  String selectedValue10 = 'Select';
  String selectedValue11 = 'Select';
  String selectedValue12 = 'Select';
  String selectedValue13 = 'Select';
  String selectedValue14 = 'Select';
  String selectedValue15 = 'Select';
  String selectedValue16 = 'Select';
  String selectedValue17 = 'Select';
  List<String> list = [
    "Database Fundamentals",
    "Computer Architecture",
    "Distributed Computing Systems",
    "Cyber Security",
    "Computer Networking",
    "Software Development",
    "Programming Skills",
    "Project Management",
    "Computer Forensics Fundamentals",
    "Technical Communication skills",
    "AI ML",
    "Software Engineering",
    "Business Analysis",
    "Communication skills",
    "Data Science",
    "Troubleshooting skills",
    "Graphics Designing"
  ];

  // List of items in our dropdown menu
  var items = [
    DropdownMenuItem(
      child: Text(
        "Select",
        style: TextStyle(color: Colors.white),
      ),
      value: "Select",
    ),
    DropdownMenuItem(
      child: Text(
        "Not Interested",
        style: TextStyle(color: Colors.white),
      ),
      value: "Not Interested",
    ),
    DropdownMenuItem(
      child: Text(
        "Poor",
        style: TextStyle(color: Colors.white),
      ),
      value: "Poor",
    ),
    DropdownMenuItem(
      child: Text(
        "Beginner",
        style: TextStyle(color: Colors.white),
      ),
      value: "Beginner",
    ),
    DropdownMenuItem(
      child: Text(
        "Average",
        style: TextStyle(color: Colors.white),
      ),
      value: "Average",
    ),
    DropdownMenuItem(
      child: Text(
        "Excellent",
        style: TextStyle(color: Colors.white),
      ),
      value: "Excellent",
    ),
    DropdownMenuItem(
      child: Text(
        "Professional",
        style: TextStyle(color: Colors.white),
      ),
      value: "Professional",
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 628,
            child: ListView.builder(
              itemCount: 17,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            list[index],
                            style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: bottomTabColor, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: bottomTabColor, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: DEEP_PURPLE,
                        ),
                        dropdownColor:LIGHT_PURPLE,
                        value: index == 0
                            ? selectedValue1
                            : index == 1
                                ? selectedValue2
                                : index == 2
                                    ? selectedValue3
                                    : index == 3
                                        ? selectedValue4
                                        : index == 4
                                            ? selectedValue5
                                            : index == 5
                                                ? selectedValue6
                                                : index == 6
                                                    ? selectedValue7
                                                    : index == 7
                                                        ? selectedValue8
                                                        : index == 8
                                                            ? selectedValue9
                                                            : index == 9
                                                                ? selectedValue10
                                                                : index == 10
                                                                    ? selectedValue11
                                                                    : index ==
                                                                            11
                                                                        ? selectedValue12
                                                                        : index ==
                                                                                12
                                                                            ? selectedValue13
                                                                            : index == 13
                                                                                ? selectedValue14
                                                                                : index == 14
                                                                                    ? selectedValue15
                                                                                    : index == 15
                                                                                        ? selectedValue16
                                                                                        : index == 16
                                                                                            ? selectedValue17
                                                                                            : selectedValue1,
                        onChanged: (newValue) {
                          setState(() {
                            index == 0
                                ? selectedValue1 = newValue.toString()
                                : index == 1
                                    ? selectedValue2 = newValue.toString()
                                    : index == 2
                                        ? selectedValue3 = newValue.toString()
                                        : index == 3
                                            ? selectedValue4 =
                                                newValue.toString()
                                            : index == 4
                                                ? selectedValue5 =
                                                    newValue.toString()
                                                : index == 5
                                                    ? selectedValue6 =
                                                        newValue.toString()
                                                    : index == 6
                                                        ? selectedValue7 =
                                                            newValue.toString()
                                                        : index == 7
                                                            ? selectedValue8 =
                                                                newValue
                                                                    .toString()
                                                            : index == 8
                                                                ? selectedValue9 =
                                                                    newValue
                                                                        .toString()
                                                                : index == 9
                                                                    ? selectedValue10 =
                                                                        newValue
                                                                            .toString()
                                                                    : index ==
                                                                            10
                                                                        ? selectedValue11 =
                                                                            newValue
                                                                                .toString()
                                                                        : index ==
                                                                                11
                                                                            ? selectedValue12 =
                                                                                newValue.toString()
                                                                            : index == 12
                                                                                ? selectedValue13 = newValue.toString()
                                                                                : index == 13
                                                                                    ? selectedValue14 = newValue.toString()
                                                                                    : index == 14
                                                                                        ? selectedValue15 = newValue.toString()
                                                                                        : index == 15
                                                                                            ? selectedValue16 = newValue.toString()
                                                                                            : index == 16
                                                                                                ? selectedValue17 = newValue.toString()
                                                                                                : selectedValue1 = newValue.toString();
                          });
                        },
                        items: items),
                  ],
                ),
              ),
            ),
          ),
          // Flexible(
          //   child: Container(
          //     margin: EdgeInsets.only(bottom: 10),
          //     decoration: BoxDecoration(color: Colors.pinkAccent),
          //     child: IconButton(
          //         color: Colors.black,
          //         onPressed: () async {},
          //         icon: Icon(Icons.login)),
          //   ),
          // )
        ],
      )

      // Center(
      //     child: Text(
      //   textShow,
      //   style: TextStyle(color: Colors.white, fontSize: 25),
      // ))
      ,
      appBar: appbar,
      floatingActionButton: FloatingActionButton(
          backgroundColor: authButtonColor,
          child: Icon(Icons.login),
          onPressed: () async {
            //http://10.0.2.2:5000/predict
            final response = await http.post(
              Uri.parse('http://192.168.196.210:50162/predict'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode({
                "Database Fundamentals": "${selectedValue1.toString()}",
                "Computer Architecture": "${selectedValue2.toString()}",
                "Distributed Computing Systems": "${selectedValue3.toString()}",
                "Cyber Security": "${selectedValue4.toString()}",
                "Computer Networking": "${selectedValue5.toString()}",
                "Software Development": "${selectedValue6.toString()}",
                "Programming Skills": "${selectedValue7.toString()}",
                "Project Management": "${selectedValue8.toString()}",
                "Computer Forensics Fundamentals":
                    "${selectedValue9.toString()}",
                "Technical Communication skills":
                    "${selectedValue10.toString()}",
                "AI ML": "${selectedValue11.toString()}",
                "Software Engineering": "${selectedValue12.toString()}",
                "Business Analysis": "${selectedValue13.toString()}",
                "Communication skills": "${selectedValue14.toString()}",
                "Data Science": "${selectedValue15.toString()}",
                "Troubleshooting skills": "${selectedValue16.toString()}",
                "Graphics Designing": "${selectedValue17.toString()}"
              }),
            );
            final Map<String, dynamic> data = json.decode(response.body);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Predicted(
                          values: data.values.toList(),
                        )));
            print(response.body);
            //   final _prefs = await SharedPreferences.getInstance();
            //
            //   setState(() {
            //     textShow = "Listening";
            //   });
            //   stt.SpeechToText speech = stt.SpeechToText();
            //   bool available =
            //       await speech.initialize(onStatus: (a) {}, onError: (a) {});
            //   if (available) {
            //     await speech.listen(onResult: (r) {
            //       setState(() {
            //         textShow = r.recognizedWords;
            //       });
            //     });
            //   } else {
            //     print("The user has denied the use of speech recognition.");
            //   }
          }),
    );
  }
}
