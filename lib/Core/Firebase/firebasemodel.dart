import 'package:cloud_firestore/cloud_firestore.dart';

class Data {
  double? pressure;
  double? feet;
  double? percentageFilled;

  createMap() {
    return {
      "pressure": pressure,
      "feet": feet,
      "percentageFilled": percentageFilled
    };
  }
}

class FirebaseModal {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  updateData(Data data) {
    var pointingCollection =
        instance.collection("root").doc("data").set(data.createMap());
  }
}
