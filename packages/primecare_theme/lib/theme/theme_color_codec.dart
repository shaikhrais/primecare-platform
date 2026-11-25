import 'package:flutter/material.dart';

/// Decode the validated #RRGGBB format used by advanced-theme previews.
Color themeHexColor(String value) {
  if (!RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(value)) {
    throw FormatException('Expected a #RRGGBB theme color',value);
  }
  return Color(int.parse(value.substring(1),radix:16)|0xff000000);
}

// Shared fixed reference color tokens for shell and palette controls.
abstract final class PrimeReferenceColors {
  static const transparent = Colors.transparent;
  static const white = Colors.white;
  static const black = Colors.black;
  static const flagUsNavy = Color(0xff3c3b6e);
  static const flagUsRed = Color(0xffb22234);
  static const flagFrenchBlue = Color(0xff0055a4);
  static const flagFrenchRed = Color(0xffef4135);
  static const flagSpanishRed = Color(0xffaa151b);
  static const flagSpanishYellow = Color(0xfff1bf00);
  static const drawerScrim = Color(0x80000000);
  static const drawerShadowNear = Color(0x21000000);
  static const drawerShadowFar = Color(0x1C000000);
  static const accountMenuShadow = Color(0x66000000);
  static const accountMenuLightShadow = Color(0x7A000000);
  static const accountLightOutline = Color(0xffd1d5db);

  static Color fromArgb(int alpha, int red, int green, int blue) =>
      Color.fromARGB(alpha, red, green, blue);
}
