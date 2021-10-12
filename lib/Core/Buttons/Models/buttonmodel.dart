import 'package:flutter/material.dart';
import 'package:untitled/Designs/designs.dart';

class ButtonModel extends StatelessWidget {
  final Color buttonColor;
  final String buttonLabel;
  final String measureUnit;

  const ButtonModel({required this.buttonColor, required this.buttonLabel, required this.measureUnit, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          top: 15,
          bottom: 5,
        ),
        child: Center(
          child: RichText(
            text: TextSpan(text: buttonLabel, style: poppins(textDark, h2, FontWeight.bold), children: <TextSpan>[
              TextSpan(
                text: " " + measureUnit,
                style: poppins(textLight, h6, FontWeight.w600),
              )
            ]),
          ),
        ));
  }
}

class BottomText extends StatelessWidget {
  final String buttomText;
  const BottomText({required this.buttomText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      buttomText,
      style: poppins(textDark, h6, FontWeight.normal),
    );
  }
}

class BigButton extends StatelessWidget {
  final Color buttonColor;
  final String label;
  final String shortDescription;
  const BigButton({required this.buttonColor, required this.shortDescription, required this.label, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 7),
      decoration: BoxDecoration(
          border: Border.all(color: textLight, width: 0.16),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 5),
            child: Text(
              label,
              style: poppins(textDark, h3, FontWeight.w600),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
            child: Text(
              shortDescription,
              style: poppins(textLight, h5, FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
