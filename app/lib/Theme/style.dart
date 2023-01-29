import 'package:dochub/Theme/colors.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  fontFamily: 'Montserrat',
  scaffoldBackgroundColor: scaffoldBg,
  accentColor: Colors.white,
  backgroundColor: scaffoldBg,

  unselectedWidgetColor: greyColor,
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0.0,
  ),

  //text theme
  textTheme: TextTheme(
    //default text style of Text Widget
    bodyText1:
    TextStyle(color: titleColor, fontWeight: FontWeight.bold, fontSize: 14),
    bodyText2: TextStyle(color: Colors.black87),
    subtitle1: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
    headline3:
    TextStyle(color: titleColor, fontWeight: FontWeight.bold, fontSize: 14),
    headline5:
    TextStyle(color: titleColor, fontWeight: FontWeight.bold, fontSize: 14),
    headline6:
    TextStyle(color: titleColor, fontWeight: FontWeight.bold, fontSize: 14),
    caption:
    TextStyle(color: titleColor, fontWeight: FontWeight.bold, fontSize: 14),
    overline: TextStyle(),
  ) /*.apply(displayColor: Colors.black)*/,
);