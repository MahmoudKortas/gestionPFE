import 'package:flutter/material.dart';
import 'package:gestion_pfe/src/color_hex.dart';

ThemeData lightTheme = ThemeData(
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black, //thereby
    ),
    appBarTheme: AppBarTheme(
      color: HexColor("c9242e"),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          HexColor("c9242e"),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: HexColor("5b5b5c"),
        ),
      ),
    ),
    
    


    /*textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.teal,
    ),
  ),
  scaffoldBackgroundColor: Colors.grey[200],
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.teal[800],
  ),*/
    );

ThemeData darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 0, 0, 0),
  ),
  /*textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.teal,
    ),
  ),
  scaffoldBackgroundColor: Colors.grey[200],
  textTheme: const TextTheme(
    bodyText1: TextStyle(),
    bodyText2: TextStyle(),
  ).apply(
    bodyColor: Colors.teal[800],
  ),*/
);
