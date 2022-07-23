import 'dart:io';
import 'package:flutter/material.dart';
import 'ge_colors.dart';

class GEAppTheme {
  //Add application-wide theme here.
  ThemeData getGlobalAppTheme(BuildContext context) {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: GEColors.screenBackground,
      primaryColor: GEColors.darkBlue,
      appBarTheme: _appBarTheme(),
      textTheme: Platform.isAndroid //Android & iOS specific text theme
          ? Typography.blackMountainView
          : Typography.blackCupertino,
    );
  }

  AppBarTheme? _appBarTheme() {
    return const AppBarTheme(
        centerTitle: true,
        backgroundColor: GEColors.darkBlue,
        elevation: 10,
        titleTextStyle: TextStyle(fontSize: 18, color: Colors.white));
  }
}
