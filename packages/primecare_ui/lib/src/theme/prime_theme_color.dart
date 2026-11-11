import 'package:flutter/material.dart';

/// Theme input parsing shared by branding controls and their previews.
abstract final class PrimeThemeColor {
  /// Accept RGB or ARGB hex, matching the branding editor's existing format.
  /// Partial and invalid input stays unset while the user types.
  static Color? tryParseHex(String input) {
    final clean=input.replaceAll('#','').trim();
    if ((clean.length!=6 && clean.length!=8) || !RegExp(r'^[0-9a-fA-F]+$').hasMatch(clean)) {
      return null;
    }
    final value=int.tryParse(clean,radix:16);
    return value==null ? null : Color(clean.length==6 ? 0xFF000000|value : value);
  }
}
