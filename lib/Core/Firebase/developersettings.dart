import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Core/Buttons/Models/remasteredbutton.dart';
import 'package:untitled/Core/Home/home.dart';
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
    Widget builder(label, key) {
      return Container(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: waterColor, width: 1)),
        child: TextField(
          onChanged: (value) {
            if (value == "") {
              final snackBar = SnackBar(
                  backgroundColor: red,
                  content: Text('Fields cannot be empty'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              var val = double.parse(value);
              switch (key) {
                case 1:
                  data.pressure = val;
                  break;
                case 2:
                  data.feet = val;
                  break;
                case 3:
                  data.flowRate = val;
                  break;
                case 4:
                  data.temperate = val;
                  break;
                case 5:
                  data.humidity = val;
                  break;
                case 6:
                  data.percentageFilled = val;
                  break;
              }
            }
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: label,
              labelStyle: poppins(textLight, h6, FontWeight.w500)),
        ),
      );
    }

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
                  Container(
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 8),
                      child: RemasteredShowcase(
                        showcase: showcase,
                      )),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
                    child: Text(
                      "Modify Data",
                      style: poppins(textLight, h6),
                    ),
                  ),
                  builder("Water Pressure", 1),
                  builder("Water Level", 2),
                  builder("Flow rate", 3),
                  builder("Temperature", 4),
                  builder("Humidity", 5),
                  builder("Percentage Changed", 6),
                  InkWell(
                    onTap: () {
                      var status = F.updateData(data);
                      if (status) {
                        final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Data update requested.',
                              style: poppins(textDark, h5),
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                            backgroundColor: red,
                            content: Text(
                              'Data is missing in the fields',
                              style: poppins(
                                backgroundColor,
                                h5,
                              ),
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: waterColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          "Save data",
                          style: poppins(textDark, h3, FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
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
