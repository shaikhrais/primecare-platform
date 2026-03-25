import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme.dart';

enum PrimeCareThemeType { light, dark, highContrast }

class ThemeNotifier extends Notifier<PrimeCareThemeType> {
  @override
  PrimeCareThemeType build() {
    return PrimeCareThemeType.light;
  }

  void setTheme(PrimeCareThemeType themeType) {
    state = themeType;
  }

  ThemeData get activeThemeData {
    switch (state) {
      case PrimeCareThemeType.light:
        return PrimeCareTheme.lightTheme;
      case PrimeCareThemeType.dark:
        return PrimeCareTheme.darkTheme;
      case PrimeCareThemeType.highContrast:
        return PrimeCareTheme.darkTheme;
    }
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, PrimeCareThemeType>(() {
  return ThemeNotifier();
});
