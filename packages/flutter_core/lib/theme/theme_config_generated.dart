// Generated file. Do not edit directly. Edit theme_config.json in root.
import 'package:flutter/material.dart';

class ThemeConfig {
  static const Map<String, Map<String, String>> _data = {
    'clinic': {
      'primary': '#0F766E',
      'primaryContainer': '#CCFBF1',
      'sidebarBackground': '#0F766E',
      'topbarBackground': '#0F766E',
    },
    'corporate': {
      'primary': '#0D1B2A',
      'sidebarBackground': '#0D1B2A',
      'topbarBackground': '#0D1B2A',
    },
    'auth': {
      'primary': '#004AC6',
      'sidebarBackground': '#0F172A',
      'topbarBackground': '#0F172A',
    },
    'governance': {
      'primary': '#004AC6',
      'sidebarBackground': '#0F172A',
      'topbarBackground': '#0F172A',
    },
    'franchise': {
      'primary': '#0D1B2A',
      'sidebarBackground': '#0F172A',
      'topbarBackground': '#0F172A',
    },
    'client': {
      'primary': '#2563EB',
      'sidebarBackground': '#0F172A',
      'topbarBackground': '#0F172A',
    },
    'business_development': {
      'primary': '#2563EB',
      'sidebarBackground': '#0F172A',
      'topbarBackground': '#0F172A',
    },
    'marketing': {
      'primary': '#2563EB',
      'sidebarBackground': '#0F172A',
      'topbarBackground': '#0F172A',
    },
    'support': {
      'primary': '#2563EB',
      'sidebarBackground': '#0F172A',
      'topbarBackground': '#0F172A',
    },
    'enterprise_blueprint': {
      'primary': '#2563EB',
      'sidebarBackground': '#0F172A',
      'topbarBackground': '#0F172A',
    },
  };

  static Color getColor(String app, String key, Color fallback) {
    final appConfig = _data[app];
    if (appConfig != null && appConfig[key] != null) {
      final hex = appConfig[key]!;
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    }
    return fallback;
  }
}
