import 'Models/bucketmodel.dart';

class Bucket {
  late String bucketStream;
  late double bucketHeight;
  late BucketModel model;
  late double waterHeight;

  setBucketStream(String bucketStream) {
    this.bucketStream = bucketStream;
  }

  setBucketHeight(double bucketHeight) {
    this.bucketHeight = bucketHeight;
  }

  setWaterHeight(double bucketHeight) {
    waterHeight = bucketHeight;
  }

  BucketModel getModel() {
    return model;
  }

  String? getBucketStream() {
    return bucketStream;
  }

  double? getBucketHeight() {
    return bucketHeight;
  }

  renderModel() {
    model = BucketModel(
      bucketHeight: bucketHeight,
      waterHeight: waterHeight,
    );
  }
}
