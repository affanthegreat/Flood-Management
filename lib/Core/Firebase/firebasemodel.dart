import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFetchModel {
  FirebaseFirestore instance = FirebaseFirestore.instance;

  updateData(map) {
    try {
      var pointingCollection = instance.collection("root").doc("data").set(map);
    } catch (e) {
      rethrow;
    }
  }

  getData() {
    var stream = instance.collection('users').doc('ABC123').snapshots();
  }
}
