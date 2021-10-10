import 'package:flutter/material.dart';
import 'package:untitled/Core/Buttons/Models/buttonmodel.dart';

class Button {
  late String bottomText;
  late String buttonLabel;
  late String measureUnit;
  late ButtonModel button;
  late Color buttonColor;
  late BottomText bottomTextModel;

  String getBottomText() {
    return bottomText;
  }

  String getButtonLabel() {
    return buttonLabel;
  }

  ButtonModel getButtonModel() {
    return button;
  }

  BottomText getBottomTextModel() {
    return bottomTextModel;
  }

  setButtonColor(Color buttonColor) {
    this.buttonColor = buttonColor;
  }

  setBottomText(String bottomText) {
    this.bottomText = bottomText;
  }

  setButtonLabel(String buttonLabel) {
    this.buttonLabel = buttonLabel;
  }

  setMeasureUnit(String measureUnit) {
    this.measureUnit = measureUnit;
  }

  render() {
    button = ButtonModel(
      buttonColor: buttonColor,
      buttonLabel: buttonLabel,
      measureUnit: measureUnit,
    );
    bottomTextModel = BottomText(
      buttomText: bottomText,
    );
  }
}
