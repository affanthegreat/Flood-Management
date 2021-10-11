import 'package:cloud_firestore/cloud_firestore.dart';

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
}
