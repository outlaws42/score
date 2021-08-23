import 'package:flutter/material.dart';

class ThemeConfig {
  //
  ThemeConfig._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.black54,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black87,
      onPrimary: Colors.black38,
      primaryVariant: Colors.blue,
      secondary: Colors.black,
    ),
    cardTheme: CardTheme(
      color: Colors.blue,
    ),
    iconTheme: IconThemeData(
      color: Colors.blue,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 45.0,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Colors.blue,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.white54,
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.red,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Colors.black87,
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Color(0xFFE7bd3b), width: 20),
      ),
      padding: EdgeInsets.all(18),
      buttonColor: Color(0xFFE7bd3b), // blue 0xFF4286f4 yellow 0xFFE7bd3b
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromRGBO(35, 38, 37, 1),//Color(0xFF464646), // 0xFF3D3D3D
    appBarTheme: AppBarTheme(
      color: Colors.teal,//Color(0xFF464646),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.black,
      onPrimary: Colors.black38,
      primaryVariant: Colors.teal,
      secondary: Colors.black,
    ),
    cardTheme: CardTheme(
      color: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.white54,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 45.0,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.white70,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.white54,
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.red,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Color.fromRGBO(255, 255, 255, .85), // white
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        //side: BorderSide(color: Color(0xFFE7bd3b), width: 2),
      ),
      padding: EdgeInsets.all(18),
      buttonColor: Color(0xFFE7bd3b), // blue 0xFF4286f4 yellow 0xFFE7bd3b
    ),
  );
}
