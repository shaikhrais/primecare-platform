import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_state.dart';

class ThemeNotifier extends Notifier<AppThemeState> {
  @override
  AppThemeState build() {
    return AppThemeState(
      mode: ThemeMode.light,
      colors: AppColors.light(),
    );
  }

  void toggleTheme() {
    if (state.mode == ThemeMode.light) {
      state = AppThemeState(
        mode: ThemeMode.dark,
        colors: AppColors.dark(),
      );
    } else {
      state = AppThemeState(
        mode: ThemeMode.light,
        colors: AppColors.light(),
      );
    }
  }

  void setLightMode() {
    state = AppThemeState(mode: ThemeMode.light, colors: AppColors.light());
  }

  void setDarkMode() {
    state = AppThemeState(mode: ThemeMode.dark, colors: AppColors.dark());
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, AppThemeState>(() {
  return ThemeNotifier();
});
