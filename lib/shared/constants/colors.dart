import 'package:flutter/material.dart';

class ColorConstants {
  static const Color appScaffoldBackgroundColor = Color(0xFFFFFFFF);
  static const Color primaryAccentColor = Color(0xFF282A64);
  static const Color secondaryDarkAppColor = Color(0xFF323232);
  static const Color greyedOutText = Color(0xFFB0B8C1);
  static const Color mainTextColor = black;
  static const Color accentTextColor = primaryAccentColor;
  static const Color secondaryTextColor = Color(0xFFFFFFFF);
  static const Color tipColor = Color(0xFFB6B6B6);
  static const Color inactiveLight = Color(0xFFB0B8C1);
  static const Color inactiveDark = Color(0xFF6B7785);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFF2E2E);
  static const Color green = Color(0xFF2EE700);
  // static const Color blue =  Color(0xFF007AFF);
  static const Color blue = Color(0xFF58A6FF);
  static const Color darkBlue = Color(0xFF2C80FF);
  static const Color pink = Color(0xFFFFB5B5);
  static const Color darkPink = Color(0xFFFF7979);
  static const Color lightGreen = Color(0xFF9CFF79);
  static const LinearGradient kBannerGradient = LinearGradient(
    colors: [Color(0xff000000), Color(0xff7f573d), Color(0xffc67c4e)],
    stops: [0.3, 0.85, 0.99],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
  static const Color shimmerBaseColor = greyedOutText;
  static const Color shimmerHighlightColor = inactiveLight;
  static const LinearGradient kCustomScreenGradient = LinearGradient(
    colors: [
      Color(0xff000000),
      Color(0xff000000),
      Color(0xff000000),
      Color(0xff000000),
      Color(0xff25201d),
      Color(0xffc67c4e)
    ],
    stops: [0.2, 0.4, 0.5, 0.7, 0.9, 1],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
