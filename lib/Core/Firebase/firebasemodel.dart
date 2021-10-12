import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Core/Home/Drawer/drawer.dart';
import 'package:untitled/Designs/designs.dart';

class Data {
  double? pressure;
  double? feet;
  double? percentageFilled;
  double? flowRate;
  double? temperate;
  double? humidity;

  createMap() {
    return {
      "pressure": pressure,
      "feet": feet,
      "percentageFilled": percentageFilled,
      "flowrate": flowRate,
      "temperature": temperate,
      "humidity": humidity,
    };
  }
}

class Report {
  String title = "";
  String summary = "";
  String url = "";
  String epoch = "";

  createMap() {
    return {'title': title, 'summary': summary, 'url': url, 'epoch': epoch};
  }
}

class FirebaseModal {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  bool updateData(Data data) {
    if (data.pressure == null ||
        data.feet == null ||
        data.percentageFilled == null ||
        data.flowRate == null ||
        data.temperate == null ||
        data.humidity == null) {
      return false;
    } else {
      var pointingCollection =
          instance.collection("root").doc("data").set(data.createMap());
      return true;
    }
  }

  bool updateReportData(String documentName, Report data) {
    if (data.title == "" || data.url == "" || data.summary == "") {
      return false;
    } else {
      var pointingCollection = instance
          .collection("reports")
          .doc(documentName)
          .set(data.createMap());
      return true;
    }
  }

  Future<FilePickerResult?> filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf'], withData: true);
    return result;
  }

  void uploadFiles(BuildContext context, FilePickerResult? result) async {
    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      if (fileBytes != null) {
        Uint8List s = fileBytes;
        var uploaded = await firebase_storage.FirebaseStorage.instance
            .ref('reports/$fileName')
            .putData(s);
        var url = await uploaded.ref.getDownloadURL();
        report.url = url;
        var snackBar = SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              'Report uploaded',
              style: poppins(textDark, h3, FontWeight.w500),
            ));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      var snackBar = SnackBar(
          backgroundColor: red,
          content: Text(
            'Something went wrong! please try again.',
            style: poppins(backgroundColor, h3, FontWeight.w500),
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
