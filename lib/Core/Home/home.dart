import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Core/Bucket/Bucket.dart';
import 'package:untitled/Core/Buttons/Models/buttonmodel.dart';
import 'package:untitled/Core/Buttons/Models/remasteredbutton.dart';
import 'package:untitled/Core/Buttons/button.dart';
import 'package:untitled/Designs/designs.dart';

import 'Drawer/drawer.dart';
import 'NavigationBar/customnavigationbar.dart';

var showcase = Showcase();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Bucket bucket;
  late CustomDrawer drawer;
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;
  List<Button> buttons = [];

  @override
  void initState() {
    // TODO: implement initState
    //drawer configuration
    drawer = CustomDrawer();
    drawer.renderDefaultModel();
    drawer.renderDeveloperSettings();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildBottomBar() {
      return Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.all(15),
        child: CustomAnimatedBottomBar(
          containerHeight: 70,
          backgroundColor: backgroundColor,
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: Colors.blue.shade500,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.settings),
              title: const Text('Settings'),
              activeColor: Colors.blue.shade500,
              inactiveColor: _inactiveColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget statusText(bool status) {
      return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: RichText(
              text: TextSpan(
                  text: "STATUS\n",
                  style: poppins(textLight, h6, FontWeight.w600),
                  children: <TextSpan>[
                    status
                        ? TextSpan(
                            text: "Minimal",
                            style: poppins(textDark, h1 + 10, FontWeight.w700),
                          )
                        : TextSpan(
                            text: "Flood Detected!",
                            style: poppins(red, h1 + 10, FontWeight.w700),
                          )
                  ]),
            ),
          ));
    }

    var height = MediaQuery.of(context).size.height;
    var bucketHeight = height * 0.35;
    Widget getBody() {
      List<Widget> pages = [
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('root').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // Bucket Creator
              buttons = [];
              showcase = Showcase();
              bucket = Bucket();
              bucket.setBucketHeight(bucketHeight);
              bucket.setWaterHeight(bucketHeight *
                  (snapshot.data!.docs[0]['percentageFilled'] / 100));
              bucket.setBucketStream("");
              bucket.renderModel();

              //ButtonCreator
              var pressureButton = Button();
              pressureButton.setBottomText("Water Pressure");
              pressureButton.setButtonColor(buttonColor);
              pressureButton.setMeasureUnit("psi");
              pressureButton.setButtonLabel(
                  snapshot.data!.docs[0]['pressure'].toString());
              pressureButton.render();

              var levelButton = Button();
              levelButton.setBottomText("Water Level (in ft)");
              levelButton.setButtonColor(buttonColor);
              levelButton.setMeasureUnit("ft");
              levelButton
                  .setButtonLabel(snapshot.data!.docs[0]['feet'].toString());
              levelButton.render();

              var flowRate = Button();
              flowRate.setBottomText("Flow rate");
              flowRate.setButtonColor(buttonColor);
              flowRate.setMeasureUnit("gpm");
              flowRate.setButtonLabel(
                  snapshot.data!.docs[0]['flowrate'].toString());
              flowRate.render();

              var humidity = Button();
              humidity.setBottomText("Humidity");
              humidity.setButtonColor(buttonColor);
              humidity.setMeasureUnit("");
              humidity.setButtonLabel(
                  snapshot.data!.docs[0]['humidity'].toString());
              humidity.render();

              var temperature = Button();
              temperature.setBottomText("Temperature");
              temperature.setButtonColor(buttonColor);
              temperature.setMeasureUnit("°c");
              temperature.setButtonLabel(
                  snapshot.data!.docs[0]['temperature'].toString());
              temperature.render();

              var bigButton = Button();
              bigButton.setButtonLabel("Reports");
              bigButton.setButtonColor(bigButtonColor);
              bigButton.setMeasureUnit("");
              bigButton.setBottomText(
                  "Access all the previous reports related to floods in this region.");
              bigButton.render();

              showcase.addWidget(pressureButton);
              showcase.addWidget(levelButton);
              showcase.addWidget(flowRate);
              showcase.addWidget(temperature);
              showcase.addWidget(humidity);
              buttons.add(bigButton);
              var status =
                  (snapshot.data!.docs[0]['percentageFilled'] / 100) < 0.70;
              return ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  statusText(status),
                  bucket.getModel(),
                  Container(
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 8),
                      child: RemasteredShowcase(
                        showcase: showcase,
                      )),
                  BigButton(
                    label: buttons[0].buttonLabel,
                    buttonColor: buttons[0].buttonColor,
                    shortDescription: buttons[0].bottomText,
                  ),
                  Container(
                    height: 80,
                  )
                ],
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                semanticsLabel: 'Linear progress indicator',
              ));
            }
          },
        ),
        drawer.listView(context)
      ];
      return IndexedStack(
        index: _currentIndex,
        children: pages,
      );
    }

    return Scaffold(
        backgroundColor: backgroundColor,
        endDrawer: drawer.listView(context),
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Stack(
            children: [getBody(), buildBottomBar()],
          ),
        ));
  }
}
