import 'package:flutter/material.dart';
import 'package:untitled/Core/Bucket/Bucket.dart';
import 'package:untitled/Core/Buttons/Models/buttonmodel.dart';
import 'package:untitled/Core/Buttons/button.dart';
import 'package:untitled/Designs/designs.dart';

import 'Drawer/drawer.dart';
import 'NavigationBar/customnavigationbar.dart';

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
    customInit() {
      // Bucket Creator
      var height = MediaQuery.of(context).size.height;
      var width = MediaQuery.of(context).size.height;
      var bucketHeight = height * 0.45;

      bucket = Bucket();
      bucket.setBucketHeight(bucketHeight);
      bucket.setBucketStream("");
      bucket.renderModel();

      //ButtonCreator
      var pressureButton = Button();
      pressureButton.setBottomText("Water Pressure");
      pressureButton.setButtonColor(buttonColor);
      pressureButton.setMeasureUnit("psi");
      pressureButton.setButtonLabel("69");
      pressureButton.render();

      var levelButton = Button();
      levelButton.setBottomText("Water Level (in ft)");
      levelButton.setButtonColor(buttonColor);
      levelButton.setMeasureUnit("ft");
      levelButton.setButtonLabel("69");
      levelButton.render();

      var bigButton = Button();
      bigButton.setButtonLabel("Reports");
      bigButton.setButtonColor(bigButtonColor);
      bigButton.setMeasureUnit("");
      bigButton.setBottomText(
          "Access all the previous reports related to floods in this region.");
      bigButton.render();

      buttons.add(pressureButton);
      buttons.add(levelButton);
      buttons.add(bigButton);
    }

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

    Widget statusText() {
      return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.only(left: 15, top: 10),
            child: RichText(
              text: TextSpan(
                  text: "STATUS\n",
                  style: poppins(textDark, h5, FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Minimal",
                      style: poppins(textDark, h1 + 10, FontWeight.w600),
                    )
                  ]),
            ),
          ));
    }

    customInit();

    Widget buttonsRender() {
      return Container(
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: buttons[0].getButtonModel()),
                    buttons[0].getBottomTextModel()
                  ],
                ),
              ),
              Container(
                width: 2,
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(child: buttons[1].getButtonModel()),
                    buttons[1].getBottomTextModel()
                  ],
                ),
              )
            ],
          ));
    }

    Widget bigButton() {
      return BigButton(
        label: buttons[2].buttonLabel,
        buttonColor: buttons[2].buttonColor,
        shortDescription: buttons[2].bottomText,
      );
    }

    openDrawer(context) {
      Scaffold.of(context).openEndDrawer();
    }

    Widget getBody() {
      List<Widget> pages = [
        ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          children: [
            statusText(),
            bucket.getModel(),
            Container(
                margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
                child: buttonsRender()),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Divider(
                thickness: 0.5,
                color: textLight.withOpacity(0.5),
              ),
            ),
            bigButton(),
            Container(
              height: 80,
            )
          ],
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
          toolbarHeight: 10,
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Stack(
            children: [getBody(), buildBottomBar()],
          ),
        ));
  }
}
