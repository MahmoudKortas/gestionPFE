import 'package:flutter/material.dart';
import 'color_hex.dart';

class ApiConstants {  
  static String pfe = "/pfe/";
  static String etudiants = "/etudiants/";
  static String enseignants = "/enseignants/";
  static String document = "/document/";
  static String responsable = "/responsable/";
}

HexColor blueberry = HexColor("#4f8ff7");


BoxDecoration roundBoxDecoration() {
  return const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(20.0),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 20.0,
        offset: Offset(20, 20),
      ),
    ],
  );
}

BoxDecoration roundBox() {
  return BoxDecoration(
    color: blueberry,
    borderRadius: const BorderRadius.all(
      Radius.circular(10.0),
    ),
  );
}

OutlineInputBorder enabledRoundedTextInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    // borderSide: BorderSide(color: blueberry, width: 2),
  );
}
OutlineInputBorder roundedTextInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    // borderSide: BorderSide(color: blueberry, width: 2),
  );
}

OutlineInputBorder circularBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
  );
}

ButtonStyle roundedButton() {
  return OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    side: const BorderSide(width: 2, color: Colors.white),
  );
}
