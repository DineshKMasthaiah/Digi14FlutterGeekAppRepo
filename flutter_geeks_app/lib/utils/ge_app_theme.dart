import 'dart:io';
import 'package:flutter/material.dart';
import 'ge_colors.dart';

class GEAppTheme {

  //TODO: Add application styles and theme here.
  ThemeData getGlobalAppTheme(BuildContext context) {
    return ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        backgroundColor: GEColors.darkBlue,
        scaffoldBackgroundColor: GEColors.blueDarker,
        primaryColor: GEColors.darkBlue,
        appBarTheme: _appBarTheme(),
        textTheme: Platform.isAndroid ? Typography.blackMountainView : Typography.blackCupertino,
        buttonTheme: _getButtonTheme(context),
        elevatedButtonTheme: _getElevatedButtonTheme(),
        textButtonTheme: _getTextButtonTheme(),
        checkboxTheme: _buildCheckBoxTheme(),
        unselectedWidgetColor: Colors.blue);
  }

  CheckboxThemeData _buildCheckBoxTheme() {
    return const CheckboxThemeData(
        //TODO: add checkbox theme here
        );
  }

  AppBarTheme? _appBarTheme() {
    return const AppBarTheme(
        centerTitle: true,
        backgroundColor: GEColors.lightBlue,
        elevation: 10,
        titleTextStyle: TextStyle(fontSize: 18, color: Colors.white));
  }

  ButtonThemeData _getButtonTheme(BuildContext context) {
    return ButtonTheme.of(context).copyWith(
        buttonColor: GEColors.buttonColor, //most of our buttons are blue
        textTheme: ButtonTextTheme.primary,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)));
  }

  ElevatedButtonThemeData _getElevatedButtonTheme() {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      primary: Colors.red,
    ));
  }

  TextButtonThemeData _getTextButtonTheme() {
    return TextButtonThemeData(
        style: TextButton.styleFrom(primary: Colors.amber));
  }
}
