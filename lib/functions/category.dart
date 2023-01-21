import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/videos_category.dart';
import '../widgets/appbar.dart';

class Videos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appbar,
      body: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 8,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    if (index <=6) {
                      return Scaffold(
                          appBar: appbar,
                          body: VideoScreen()
                      );
                    } else {
                      return Scaffold(
                        appBar: appbar,
                        body: Center(
                          child: Container(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Coming Soon Keep The App Up to Date ...",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(34),
                child: GridTile(
                  footer: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'happy',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  child: CachedNetworkImage(
                    height: 200,
                    width: 200,
                    fit: BoxFit.fill,
                    imageUrl:
                    'https://i.ytimg.com/vi/lPKCOmZXoxc/default.jpg',
                    placeholder: (context, index) {
                      return Center(child: Container(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator()));
                    },
                  ),
                ),
              ),
            );
          }),
    );
  }
}