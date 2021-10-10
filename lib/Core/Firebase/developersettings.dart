import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/Designs/designs.dart';

import '../../main.dart';
import 'firebasemodel.dart';

class DeveloperOptions extends StatefulWidget {
  const DeveloperOptions({Key? key}) : super(key: key);

  @override
  _DeveloperOptionsState createState() => _DeveloperOptionsState();
}

class _DeveloperOptionsState extends State<DeveloperOptions> {
  Data data = Data();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('root').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (value) {
                      data.percentageFilled = double.parse(value);
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (value) {
                      data.feet = double.parse(value);
                    },
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    onChanged: (value) {
                      data.pressure = double.parse(value);
                    },
                  ),
                  InkWell(
                    onTap: () {
                      F.updateData(data);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      color: waterColor,
                    ),
                  )
                ],
              );
            } else {
              return Container(
                color: waterColor,
              );
            }
          }),
    );
  }
}
