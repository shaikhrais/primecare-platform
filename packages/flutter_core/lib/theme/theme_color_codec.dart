import 'package:flutter/material.dart';

/// Decode the validated #RRGGBB format used by advanced-theme previews.
Color themeHexColor(String value) {
  if (!RegExp(r'^#[0-9a-fA-F]{6}$').hasMatch(value)) {
    throw FormatException('Expected a #RRGGBB theme color',value);
  }
  return Color(int.parse(value.substring(1),radix:16)|0xff000000);
}
