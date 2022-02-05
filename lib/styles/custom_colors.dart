import 'package:flutter/material.dart';

class CustomColors {
  //TODO Define your colors here
  const CustomColors();

  static const Color primaryColor = Color.fromRGBO(255,255,255,1);
  static const buttonColor = Color.fromRGBO(204,51,255,1);
  static const accentColor = Color.fromRGBO(80, 79, 132, 1);
  static const textGrayColor = Color.fromRGBO(223,223,223,1);

  static final Color mainPurpleColor = ColorHex("#504F84");
  static final Color mainMintColor = ColorHex("#5CC2AB");
  static Color mainGrayColor = ColorHex("#5B5E6B");
  static Color mainLightGrayColor = ColorHex("#F0F0F0");
  static Color mainBlackColor = ColorHex("#33374A");

  static final Color borderLightGrayColor = Colors.black12;
  static final Color hintColor = ColorHex("#B9B9B9");

  static const Map<String, Color> gradientBlue = <String, Color>{
    "100": Color(0xFF00A3FE),
    "200": Color(0xFF0092FE),
    "300": Color(0xFF0082FE),
  };

}

class ColorHex extends Color {
  ColorHex(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
