import 'package:flutter/material.dart';
import 'package:untitled/Designs/designs.dart';

import '../button.dart';

class Showcase {
  List<Button> metricWidgets = [];
  addWidget(Button widget) {
    metricWidgets.add(widget);
  }
}

class RemasteredShowcase extends StatefulWidget {
  Showcase showcase;
  RemasteredShowcase({required this.showcase, Key? key}) : super(key: key);

  @override
  _RemasteredShowcaseState createState() => _RemasteredShowcaseState();
}

class _RemasteredShowcaseState extends State<RemasteredShowcase> {
  @override
  Widget build(BuildContext context) {
    Widget getItem(int index) {
      return Column(
        children: [
          widget.showcase.metricWidgets[index].getButtonModel(),
          widget.showcase.metricWidgets[index].getBottomTextModel(),
        ],
      );
    }

    return Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: textLight, width: 0.16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.all(10),
              child: Text(
                "Key Metrics",
                style: poppins(textLight.withOpacity(0.7), h5, FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [getItem(0), getItem(1), getItem(2)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [getItem(3), getItem(4)],
            )
          ],
        ));
  }
}
