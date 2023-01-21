import 'package:chat/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {
  _launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.skytechnohub.chat';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 17, top: 10, bottom: 10),
            child: Text(
              "Settings",
              style: TextStyle(color: Colors.white, fontSize: 27),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17, top: 10, bottom: 10),
            child: TextButton(
              onPressed: () {
                _launchURL();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.white,
                    size: 28,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      "Please Rate our app We will be waiting for your review ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 17,
            ),
            child: TextButton(
              onPressed: () {
                _launchURL();
              },
              child: Row(
                children: [
                  Icon(
                    Icons.rate_review,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Give Your Review",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}