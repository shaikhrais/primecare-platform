import 'package:flutter/material.dart';

/// WCAG contrast for opaque theme colors.
double themeContrastRatio(Color a, Color b) {
  final x = a.computeLuminance(), y = b.computeLuminance();
  return (x > y ? (x + .05) / (y + .05) : (y + .05) / (x + .05));
}

Color readableThemeForeground(Color background, Color candidate) {
  if (themeContrastRatio(candidate, background) >= 4.5) return candidate;
  return themeContrastRatio(Colors.black, background) >=
          themeContrastRatio(Colors.white, background)
      ? Colors.black
      : Colors.white;
}

/// Keep all stops readable with the same foreground as the primary color.
List<Color> readableThemeGradient(Color background, Color foreground) {
  final toward = foreground.computeLuminance() > .5 ? Colors.black : Colors.white;
  return [background, Color.lerp(background, toward, .12)!,
    Color.lerp(background, toward, .24)!];
}
