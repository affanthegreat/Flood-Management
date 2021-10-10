import 'package:flutter/material.dart';
import 'package:untitled/Designs/designs.dart';

class CustomDrawer {
  List<Widget> model = [];
  bool containsDefaultModel = false;
  bool containsDeveloperSettings = false;

  renderDefaultModel() {
    if (containsDefaultModel == false) {
      addHeading("MENU");
      addButton("Dark theme");
      addButton("Settings");
      addButton("About");
      containsDefaultModel = true;
    }
  }

  renderDeveloperSettings() {
    if (containsDeveloperSettings == false) {
      addHeading("Developer Settings");
      addButton("Update Data");
      addButton("Upload Report");
      containsDeveloperSettings = true;
    }
  }

  Widget listView(BuildContext context) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (context, index) {
        return model[index];
      },
    );
  }

  addHeading(String str) {
    var temporary = Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 2),
      child: Text(str.toUpperCase(),
          style: poppins(Colors.blue.shade400, h6, FontWeight.w600)),
    );
    var div = Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Divider(
          thickness: 2,
          color: Colors.blue.shade400,
        ));
    model.add(temporary);
    model.add(div);
  }

  addButton(String str) {
    var temporary = Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
      child: Text(str, style: poppins(textDark, h4, FontWeight.w500)),
    );
    var div = Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        child: Divider(
          thickness: 0.2,
          color: textLight.withOpacity(0.5),
        ));
    model.add(temporary);
    model.add(div);
  }

  render() {}
}