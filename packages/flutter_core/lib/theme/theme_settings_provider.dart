import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/persistence_providers.dart';

enum LayoutStyle {
  verticalLeft,
  verticalRight,
  horizontal,
  collapsed,
}

class ThemeSettingsState {
  final LayoutStyle layoutStyle;
  final String presetName;
  final bool customScrollbars;
  final TextDirection direction;
  final String? customPrimary;
  final String? customPrimaryContainer;
  final String? customSidebarBg;
  final String? customTopbarBg;

  const ThemeSettingsState({
    required this.layoutStyle,
    required this.presetName,
    required this.customScrollbars,
    required this.direction,
    this.customPrimary,
    this.customPrimaryContainer,
    this.customSidebarBg,
    this.customTopbarBg,
  });

  ThemeSettingsState copyWith({
    LayoutStyle? layoutStyle,
    String? presetName,
    bool? customScrollbars,
    TextDirection? direction,
    String? customPrimary,
    String? customPrimaryContainer,
    String? customSidebarBg,
    String? customTopbarBg,
  }) {
    return ThemeSettingsState(
      layoutStyle: layoutStyle ?? this.layoutStyle,
      presetName: presetName ?? this.presetName,
      customScrollbars: customScrollbars ?? this.customScrollbars,
      direction: direction ?? this.direction,
      customPrimary: customPrimary ?? this.customPrimary,
      customPrimaryContainer: customPrimaryContainer ?? this.customPrimaryContainer,
      customSidebarBg: customSidebarBg ?? this.customSidebarBg,
      customTopbarBg: customTopbarBg ?? this.customTopbarBg,
    );
  }
}

class ThemeSettingsNotifier extends Notifier<ThemeSettingsState> {
  static const _layoutKey = 'theme_layout_style';
  static const _presetKey = 'theme_preset_name';
  static const _scrollbarsKey = 'theme_custom_scrollbars';
  static const _directionKey = 'theme_direction';
  static const _customPrimaryKey = 'theme_custom_primary';
  static const _customPrimaryContainerKey = 'theme_custom_primary_container';
  static const _customSidebarBgKey = 'theme_custom_sidebar_bg';
  static const _customTopbarBgKey = 'theme_custom_topbar_bg';

  @override
  ThemeSettingsState build() {
    final prefs = ref.watch(sharedPreferencesProvider);

    final layoutStr = prefs?.getString(_layoutKey) ?? 'vertical-left';
    final preset = prefs?.getString(_presetKey) ?? 'navyTealPalette';
    final scrollbars = prefs?.getBool(_scrollbarsKey) ?? false;
    final directionStr = prefs?.getString(_directionKey) ?? 'ltr';

    final customPrimary = prefs?.getString(_customPrimaryKey);
    final customPrimaryContainer = prefs?.getString(_customPrimaryContainerKey);
    final customSidebarBg = prefs?.getString(_customSidebarBgKey);
    final customTopbarBg = prefs?.getString(_customTopbarBgKey);

    LayoutStyle layout;
    switch (layoutStr) {
      case 'vertical-right':
        layout = LayoutStyle.verticalRight;
        break;
      case 'horizontal':
        layout = LayoutStyle.horizontal;
        break;
      case 'collapsed':
        layout = LayoutStyle.collapsed;
        break;
      default:
        layout = LayoutStyle.verticalLeft;
    }

    final direction = directionStr == 'rtl' ? TextDirection.rtl : TextDirection.ltr;

    return ThemeSettingsState(
      layoutStyle: layout,
      presetName: preset,
      customScrollbars: scrollbars,
      direction: direction,
      customPrimary: customPrimary,
      customPrimaryContainer: customPrimaryContainer,
      customSidebarBg: customSidebarBg,
      customTopbarBg: customTopbarBg,
    );
  }

  Future<void> updateLayoutStyle(LayoutStyle style) async {
    state = state.copyWith(layoutStyle: style);
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs != null) {
      String styleStr;
      switch (style) {
        case LayoutStyle.verticalRight:
          styleStr = 'vertical-right';
          break;
        case LayoutStyle.horizontal:
          styleStr = 'horizontal';
          break;
        case LayoutStyle.collapsed:
          styleStr = 'collapsed';
          break;
        default:
          styleStr = 'vertical-left';
      }
      await prefs.setString(_layoutKey, styleStr);
    }
  }

  Future<void> updatePreset(String presetName) async {
    state = state.copyWith(presetName: presetName);
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs != null) {
      await prefs.setString(_presetKey, presetName);
    }
  }

  Future<void> toggleScrollbars(bool enabled) async {
    state = state.copyWith(customScrollbars: enabled);
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs != null) {
      await prefs.setBool(_scrollbarsKey, enabled);
    }
  }

  Future<void> updateDirection(TextDirection direction) async {
    state = state.copyWith(direction: direction);
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs != null) {
      await prefs.setString(_directionKey, direction == TextDirection.rtl ? 'rtl' : 'ltr');
    }
  }

  Future<void> updateCustomColors({
    String? primary,
    String? primaryContainer,
    String? sidebarBg,
    String? topbarBg,
  }) async {
    state = state.copyWith(
      customPrimary: primary,
      customPrimaryContainer: primaryContainer,
      customSidebarBg: sidebarBg,
      customTopbarBg: topbarBg,
    );
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs != null) {
      if (primary != null) {
        await prefs.setString(_customPrimaryKey, primary);
      } else {
        await prefs.remove(_customPrimaryKey);
      }
      if (primaryContainer != null) {
        await prefs.setString(_customPrimaryContainerKey, primaryContainer);
      } else {
        await prefs.remove(_customPrimaryContainerKey);
      }
      if (sidebarBg != null) {
        await prefs.setString(_customSidebarBgKey, sidebarBg);
      } else {
        await prefs.remove(_customSidebarBgKey);
      }
      if (topbarBg != null) {
        await prefs.setString(_customTopbarBgKey, topbarBg);
      } else {
        await prefs.remove(_customTopbarBgKey);
      }
    }
  }

  Future<void> clearCustomColors() async {
    state = ThemeSettingsState(
      layoutStyle: state.layoutStyle,
      presetName: state.presetName,
      customScrollbars: state.customScrollbars,
      direction: state.direction,
      customPrimary: null,
      customPrimaryContainer: null,
      customSidebarBg: null,
      customTopbarBg: null,
    );
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs != null) {
      await prefs.remove(_customPrimaryKey);
      await prefs.remove(_customPrimaryContainerKey);
      await prefs.remove(_customSidebarBgKey);
      await prefs.remove(_customTopbarBgKey);
    }
  }

  Future<void> resetToTenantDefault(String tenantPreset) async {
    state = ThemeSettingsState(
      layoutStyle: LayoutStyle.verticalLeft,
      presetName: tenantPreset,
      customScrollbars: false,
      direction: TextDirection.ltr,
      customPrimary: null,
      customPrimaryContainer: null,
      customSidebarBg: null,
      customTopbarBg: null,
    );
    final prefs = ref.read(sharedPreferencesProvider);
    if (prefs != null) {
      await prefs.remove(_layoutKey);
      await prefs.remove(_presetKey);
      await prefs.remove(_scrollbarsKey);
      await prefs.remove(_directionKey);
      await prefs.remove(_customPrimaryKey);
      await prefs.remove(_customPrimaryContainerKey);
      await prefs.remove(_customSidebarBgKey);
      await prefs.remove(_customTopbarBgKey);
    }
  }
}

final themeSettingsProvider = NotifierProvider<ThemeSettingsNotifier, ThemeSettingsState>(
  ThemeSettingsNotifier.new,
);
