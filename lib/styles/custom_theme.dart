// import 'package:google_fonts/google_fonts.dart';
import 'custom_text_style.dart';
import 'package:flutter/material.dart';
import 'custom_colors.dart';

class CustomTheme {
  //set your theme in MaterialApp
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.mainPurpleColor,
    backgroundColor: CustomColors.primaryColor,
    scaffoldBackgroundColor: CustomColors.primaryColor,
    appBarTheme: AppBarTheme(
      color: CustomColors.primaryColor,
      titleTextStyle: TextStyle(color: CustomColors.mainBlackColor,fontSize: 12,fontWeight: FontWeight.w600),
      elevation: 0,
      iconTheme: IconThemeData(color: CustomColors.mainBlackColor),
    ),
    buttonColor: CustomColors.buttonColor,
    // iconTheme: IconThemeData(color: CustomColors.mainPurpleColor),
    textTheme: CustomTextStyle.textThemeLight.apply(bodyColor: CustomColors.mainPurpleColor,),
    textSelectionTheme: TextSelectionThemeData(cursorColor: CustomColors.mainPurpleColor,),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: CustomColors.primaryColor,
      labelStyle: const TextStyle(fontSize: 12,),
      hintStyle: TextStyle(color: CustomColors.hintColor,fontSize: 12),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.mainPurpleColor,),
          borderRadius: BorderRadius.circular(5)
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CustomColors.borderLightGrayColor,),
          borderRadius: BorderRadius.circular(5)
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5)
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: CustomColors.mainPurpleColor,primary: CustomColors.mainPurpleColor,),
    // platform: TargetPlatform.iOS,
  );

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      accentColor: CustomColors.accentColor,
      backgroundColor: Colors.black,
      buttonColor: CustomColors.buttonColor,
      textTheme: CustomTextStyle.textThemeDark
  );
}
