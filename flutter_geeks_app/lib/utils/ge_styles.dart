import 'package:flutter/material.dart';

import 'ge_colors.dart';

//in the code
class GEStyles {
  static const TextStyle listItemTitle = TextStyle(
    fontSize: 18.0,
    color: GEColors.black,
    fontStyle: FontStyle.normal,fontWeight: FontWeight.bold
  );
  static const TextStyle textFieldValue =
  TextStyle(color: GEColors.white, fontSize: 16,fontWeight: FontWeight.bold,backgroundColor: GEColors.gray);
  static const textFieldLabel =
  TextStyle(color: GEColors.semiDarkGray, fontSize: 12);

  static const pageTitleStyle = TextStyle(
      fontSize: 18.0,
      color: GEColors.white);

  static const TextStyle listItem2ndLine = TextStyle(
      fontSize: 14.0,
      color: GEColors.listItem2ndLine,
      fontStyle: FontStyle.normal);

  static const secondaryButtonSmallTextStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14.0,
      color: GEColors.primaryButtonColor);
}