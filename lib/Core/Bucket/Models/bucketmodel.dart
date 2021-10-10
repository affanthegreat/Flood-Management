import 'package:flutter/material.dart';
import 'package:untitled/Designs/designs.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class BucketModel extends StatefulWidget {
  late double bucketHeight;
  late double waterHeight;

  BucketModel({required this.bucketHeight, required this.waterHeight, Key? key})
      : super(key: key);

  @override
  State<BucketModel> createState() => _BucketModelState();
}

class _BucketModelState extends State<BucketModel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 10),
                  height: widget.bucketHeight,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Container(
                        height: widget.bucketHeight * 0.3,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Risky",
                          style: poppins(red, h5, FontWeight.w600),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: red,
                      )
                    ],
                  ))),
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Water(
                  height: widget.bucketHeight, waterHeight: widget.waterHeight),
            ),
          ),
        ],
      ),
    );
  }
}

class Water extends StatefulWidget {
  double height;
  double waterHeight;
  Water({required this.height, required this.waterHeight, Key? key})
      : super(key: key);

  @override
  _WaterState createState() => _WaterState();
}

class _WaterState extends State<Water> {
  @override
  Widget build(BuildContext context) {
    Widget buildCard(Config config, double height) {
      return Container(
        height: widget.height,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.25),
              blurRadius: 20.0,
              spreadRadius: 7.0,
              offset: const Offset(
                5.0,
                5.0,
              ),
            )
          ],
        ),
        child: Card(
          color: backgroundColor,
          elevation: 0,
          shadowColor: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            topRight: Radius.circular(5.0),
            topLeft: Radius.circular(5.0),
          )),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: WaveWidget(
              config: config,
              size: Size(double.infinity, widget.waterHeight),
              waveAmplitude: 0.5,
            ),
          ),
        ),
      );
    }

    var config = CustomConfig(
      gradients: [
        [Colors.blue.shade100, Colors.blue.shade200],
        [Colors.blue.shade200, Colors.blue.shade400],
        [Colors.blue.shade400, Colors.blue.shade600],
      ],
      durations: [35000, 19440, 10800],
      heightPercentages: [0.0, 0.05, 0.09],
      gradientBegin: Alignment.bottomLeft,
      gradientEnd: Alignment.topRight,
    );
    return buildCard(config, widget.height);
  }
}
