import 'package:untitled/Core/Bucket/Models/bucketmodel.dart';

class Bucket {
  late String bucketStream;
  late double bucketHeight;
  late BucketModel model;

  setBucketStream(String bucketStream) {
    this.bucketStream = bucketStream;
  }

  setBucketHeight(double bucketHeight) {
    this.bucketHeight = bucketHeight;
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
    model = BucketModel(bucketHeight: bucketHeight);
  }
}
