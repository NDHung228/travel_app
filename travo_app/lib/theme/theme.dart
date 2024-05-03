import 'package:flutter/material.dart';
import 'package:travo_app/constant/utils/color_constant.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
      background: ColorConstant.backgroundColor,
      onBackground: ColorConstant.blackColor,
      primary: ColorConstant.primaryColor,
      onPrimary: ColorConstant.onPrimaryColor,
      onSecondary: ColorConstant.whiteColor,
      tertiary: Color.fromRGBO(255, 204, 128, 1),
      error: ColorConstant.errorColor,
      outline: Color(0xFF424242)),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF121212),
    onBackground: ColorConstant.whiteColor,
    primary: ColorConstant.primaryColor,
    onPrimary: ColorConstant.onPrimaryColor,
    onSecondary: ColorConstant.blackColor,
    error: ColorConstant.errorColor,
  ),
);
