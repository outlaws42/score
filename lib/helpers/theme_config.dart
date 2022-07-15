import 'package:flutter/material.dart';

class ThemeConfig {
  ThemeConfig._();

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black54,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.black87,
      onPrimary: Colors.black38,
      primaryContainer: Colors.black54,
      secondary: Color.fromARGB(255, 0, 0, 0),
      secondaryContainer: Colors.black45,
    ),
    cardTheme: CardTheme(
      elevation: 1,
      color: Colors.white,
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
        color: Colors.black87,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.black87,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Colors.black87,
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      subtitle1: TextStyle(
        color: Colors.black87,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
      subtitle2: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
      bodyText1: TextStyle(
        color: Colors.black87,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      ),
      button: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: Color(0xFFE7bd3b), width: 20),
      ),
      padding: EdgeInsets.all(18),
      buttonColor: Color(0xFFE7bd3b),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15, 
      ),
      labelStyle: TextStyle(
        fontSize: 35,
        decorationColor: Colors.red,
      ),
    )
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color.fromARGB(255, 42, 49, 53),//Color.fromRGBO(35, 38, 37, 1),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 6, 79, 72), // Color.fromARGB(255, 42, 49, 53),
      foregroundColor: Color.fromARGB(255, 42, 49, 53), //Color.fromRGBO(35, 38, 37, 1),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.white70,
      onPrimary: Colors.black38,
      primaryContainer: Color.fromARGB(255, 219, 157, 113),
      secondary: Colors.black,
      secondaryContainer: Colors.white30,
    ),
    cardTheme: CardTheme(
      elevation: 1,
      color: Colors.black87,
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
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      headline3: TextStyle(
        color: Colors.white70,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      headline5: TextStyle(
        color: Colors.white70,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
      headline6: TextStyle(
        color: Color.fromRGBO(255, 255, 255, .85), 
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
      ),
      subtitle1: TextStyle(
        color: Color.fromRGBO(255, 255, 255, .85), 
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
      subtitle2: TextStyle(
        color: Color.fromRGBO(255, 255, 255, .85), 
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
      ),
      bodyText1: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: TextStyle(
        color: Colors.white,
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
      ),
      button: TextStyle(
        color: Colors.white,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      padding: EdgeInsets.all(18),
      buttonColor: Color(0xFFE7bd3b),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 15.0, 
      ),
      labelStyle: TextStyle(
        fontSize: 35,
        decorationColor: Colors.red,
      ),
    )
  );
}
