import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Core/Firebase/developersettings.dart';
import 'package:untitled/Core/Firebase/firebasemodel.dart';
import 'package:untitled/Designs/designs.dart';

import '../../../main.dart';

class CustomDrawer {
  List<Widget> model = [];
  bool containsDefaultModel = false;
  bool containsDeveloperSettings = false;

  renderDefaultModel() {
    if (containsDefaultModel == false) {
      addHeading("MENU");
      addButton("Settings", const Scaffold());
      addButton("About", const Scaffold());
      containsDefaultModel = true;
    }
  }

  renderDeveloperSettings() {
    if (containsDeveloperSettings == false) {
      addHeading("Developer Settings");
      addButton("Update Data", const DeveloperOptions());
      addButton("Upload Report", Container());
      containsDeveloperSettings = true;
    }
  }

  Widget listView(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      itemCount: model.length,
      itemBuilder: (context, index) {
        return model[index];
      },
    );
  }

  addHeading(String str) {
    var temporary = Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 2),
      child: Text(str.toUpperCase(), style: poppins(Colors.blue.shade400, h6, FontWeight.w600)),
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

  addButton(String str, Widget route) {
    var temporary = MenuButton(str: str, widget: route);
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

var report = Report();

class MenuButton extends StatefulWidget {
  final String str;
  final Widget widget;

  const MenuButton({required this.str, required this.widget, Key? key}) : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  @override
  Widget build(BuildContext context) {
    void showDialog() {
      Widget builder(label, key) {
        return Material(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: waterColor, width: 1)),
            child: TextField(
              onChanged: (value) {
                switch (key) {
                  case 1:
                    report.title = value;
                    break;
                  case 2:
                    report.summary = value;
                    break;
                }
              },
              maxLines: 5,
              minLines: 1,
              maxLength: 40,
              decoration: InputDecoration(border: InputBorder.none, labelText: label, labelStyle: poppins(textLight, h6, FontWeight.w500)),
            ),
          ),
        );
      }

      var showLoadingScreen = false;
      FilePickerResult? file;
      showGeneralDialog(
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.15),
        transitionDuration: const Duration(milliseconds: 350),
        context: context,
        pageBuilder: (_, __, ___) {
          return Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 450,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Material(
                          type: MaterialType.transparency,
                          child: Container(
                            height: 90,
                            margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                            alignment: Alignment.centerLeft,
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Upload data",
                                style: poppins(textLight, h4, FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        builder("Title of the report", 1),
                        builder("Short Summary", 2),
                        Material(
                          child: Container(
                            margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "File to upload",
                                  style: poppins(textDark, h5, FontWeight.w500),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (report.title == "" || report.summary == "") {
                                      Navigator.pop(context);
                                      var snackBar = SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(
                                            'Fields are empty',
                                            style: poppins(textDark, h3, FontWeight.w500),
                                          ));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    } else {
                                      F.filePicker().then((value) {
                                        setState(() {
                                          file = value;
                                        });
                                      });
                                      setState(() {});
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: textLight, width: 0.26),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 10.0,
                                            spreadRadius: 0.0,
                                            offset: const Offset(
                                              3.0,
                                              3.0,
                                            ),
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                      child: Text(
                                        file == null ? "Choose file" : "File chosen.",
                                        style: poppins(textLight, h6, FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Material(
                          child: InkWell(
                            onTap: () {
                              if (report.title == "" || report.summary == "" || file == null) {
                                Navigator.pop(context);
                                var snackBar = SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Fields are empty',
                                      style: poppins(textDark, h3, FontWeight.w500),
                                    ));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              } else {
                                setState(() {
                                  showLoadingScreen = true;
                                });

                                report.epoch = DateTime.now().millisecondsSinceEpoch.toString();
                                FilePickerResult f = file!;
                                F.uploadFiles(context, f);
                                if (report.url != "") {
                                  F.uploadFiles(context, f);
                                  var status = F.updateReportData(report.epoch, report);
                                  setState(() {
                                    showLoadingScreen = false;
                                  });

                                  if (status == true) {
                                    Navigator.pop(context);
                                    var snackBar = SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text(
                                          'Upload completed.',
                                          style: poppins(Colors.white, h3, FontWeight.w500),
                                        ));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  } else {
                                    Navigator.pop(context);
                                    var snackBar = SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          'Error while uploading.',
                                          style: poppins(Colors.white, h3, FontWeight.w500),
                                        ));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                }
                              }
                            },
                            child: Container(
                              height: 70,
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  border: Border.all(color: textLight, width: 0.26),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.shade300,
                                      blurRadius: 10.0,
                                      spreadRadius: 0.0,
                                      offset: const Offset(
                                        2.0,
                                        3.0,
                                      ),
                                    )
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  showLoadingScreen ? "Uploading.." : "Upload report",
                                  style: poppins(textDark, h3, FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          offset: const Offset(
                            5.0,
                            5.0,
                          ),
                          blurRadius: 25.0,
                          spreadRadius: 10.0,
                        )
                      ],
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              showLoadingScreen
                  ? BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container()
            ],
          );
        },
        transitionBuilder: (_, anim, __, child) {
          return SlideTransition(
            position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0)).animate(anim),
            child: child,
          );
        },
      );
    }

    return InkWell(
        onTap: () {
          if (widget.str == 'Upload Report') {
            showDialog();
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget.widget));
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
          child: Text(widget.str, style: poppins(textDark, h4, FontWeight.w500)),
        ));
  }
}
