import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var backgroundColor = const Color(0xffffffff);
var textLight = const Color(0xffa3a3a3);
var textDark = const Color(0xff4f4f4f);
var waterColor = const Color(0xff6CD7EF);
var beakerColor = const Color(0xffF1F1F1);
var red = const Color(0xffFF7171);
var buttonColor = const Color(0xffF6F6EB);
var bigButtonColor = const Color(0xffF8F8F8);

double h1 = 32;
double h2 = 24;
double h3 = 19;
double h4 = 17;
double h5 = 15;
double h6 = 13;

TextStyle poppins(Color col, [double? x, FontWeight? weight]) {
  return GoogleFonts.poppins(textStyle: TextStyle(height: 1.5, letterSpacing: -0.5, fontWeight: weight ?? FontWeight.bold, color: col, fontSize: x ?? h5));
}

TextStyle tt(Color col, [double? x, FontWeight? weight]) {
  return GoogleFonts.notoSerif(textStyle: TextStyle(height: 1.5, fontWeight: weight ?? FontWeight.bold, color: col, fontSize: x ?? h5));
}
