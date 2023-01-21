import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/appbar.dart';

class Predicted extends StatefulWidget {
  final List values;
  const Predicted({Key? key, required this.values}) : super(key: key);

  @override
  State<Predicted> createState() => _PredictedState();
}

class _PredictedState extends State<Predicted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              "You have better career in this job profile",
              style: TextStyle(color: Colors.white, fontSize: 24),
            )),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: ListView.builder(
                itemCount: widget.values.length,
                itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ))),
          ),
        ],
      ),
    );
  }
}
