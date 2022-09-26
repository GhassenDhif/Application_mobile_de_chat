
import 'package:flutter/material.dart';


///**************theme de l'application ***************///

ThemeData lightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: IconThemeData(
      size: 15,
      color: Colors.black,
    ),
  ),
  scaffoldBackgroundColor: Colors.white
);

ThemeData darkTheme = ThemeData.dark().copyWith(

);