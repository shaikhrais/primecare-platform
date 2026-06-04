const fs = require('fs');
const path = require('path');

const rootDir = path.resolve(__dirname, '..');
const configPath = path.join(rootDir, 'theme_config.json');
const presetsPath = path.join(__dirname, 'fuse_presets.json');
const outputPath = path.join(rootDir, 'packages', 'flutter_core', 'lib', 'theme', 'theme_config_generated.dart');

// Helper to convert CSS color string to Dart Color constructor
function toDartColor(colorStr) {
  if (!colorStr) return 'Color(0xFF000000)';
  colorStr = colorStr.trim();
  if (colorStr.startsWith('#')) {
    let hex = colorStr.substring(1);
    if (hex.length === 3) {
      hex = hex.split('').map(c => c + c).join('');
    }
    return `Color(0xFF${hex.toUpperCase()})`;
  }
  if (colorStr.startsWith('rgb')) {
    const match = colorStr.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*([\d.]+))?\)/);
    if (match) {
      const r = parseInt(match[1]).toString(16).padStart(2, '0');
      const g = parseInt(match[2]).toString(16).padStart(2, '0');
      const b = parseInt(match[3]).toString(16).padStart(2, '0');
      let a = 'FF';
      if (match[4]) {
        const alpha = parseFloat(match[4]);
        a = Math.round(alpha * 255).toString(16).padStart(2, '0');
      }
      return `Color(0x${(a + r + g + b).toUpperCase()})`;
    }
  }
  // Fallback for default names if any
  return 'Color(0xFF000000)';
}

try {
  const presetsContent = fs.readFileSync(presetsPath, 'utf8');
  const presets = JSON.parse(presetsContent);

  const configContent = fs.readFileSync(configPath, 'utf8');
  const userConfig = JSON.parse(configContent);

  let dartContent = `// Generated file. Do not edit directly. Edit theme_config.json in root.
import 'package:flutter/material.dart';

class AppThemePalette {
  final Brightness brightness;
  final Color primary;
  final Color primaryContainer;
  final Color primaryDark;
  final Color onPrimary;
  final Color secondary;
  final Color secondaryContainer;
  final Color secondaryDark;
  final Color onSecondary;
  final Color background;
  final Color surface;
  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;
  final Color divider;
  final Color sidebarBackground;
  final Color topbarBackground;
  final String defaultLanguage;
  final List<String> supportedLanguages;

  const AppThemePalette({
    required this.brightness,
    required this.primary,
    required this.primaryContainer,
    required this.primaryDark,
    required this.onPrimary,
    required this.secondary,
    required this.secondaryContainer,
    required this.secondaryDark,
    required this.onSecondary,
    required this.background,
    required this.surface,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.divider,
    required this.sidebarBackground,
    required this.topbarBackground,
    required this.defaultLanguage,
    required this.supportedLanguages,
  });
}

class ThemeConfig {
  static const Map<String, AppThemePalette> _data = {
`;

  for (const [app, config] of Object.entries(userConfig)) {
    const presetName = config.preset || 'default';
    const preset = presets[presetName] || presets['default'];

    // Deep copy/merge palette values
    const palette = {
      mode: config.mode || preset.mode,
      primary: {
        main: config.primary || config.primaryMain || preset.primary.main,
        light: config.primaryContainer || config.primaryLight || preset.primary.light,
        dark: config.primaryDark || preset.primary.dark,
        contrastText: config.onPrimary || config.primaryContrastText || preset.primary.contrastText,
      },
      secondary: {
        main: config.secondary || config.secondaryMain || preset.secondary.main,
        light: config.secondaryContainer || config.secondaryLight || preset.secondary.light,
        dark: config.secondaryDark || preset.secondary.dark,
        contrastText: config.onSecondary || config.secondaryContrastText || preset.secondary.contrastText,
      },
      background: {
        default: config.background || config.backgroundDefault || preset.background.default,
        paper: config.surface || config.backgroundPaper || preset.background.paper,
      },
      text: {
        primary: config.textPrimary || preset.text.primary,
        secondary: config.textSecondary || preset.text.secondary,
        disabled: config.textDisabled || preset.text.disabled,
      },
      divider: config.divider || preset.divider,
      sidebarBackground: config.sidebarBackground || preset.sidebarBackground,
      topbarBackground: config.topbarBackground || preset.topbarBackground,
    };

    const brightness = palette.mode === 'dark' ? 'Brightness.dark' : 'Brightness.light';

    const defaultLanguage = config.defaultLanguage || 'en';
    const supportedLanguages = config.supportedLanguages || ['en', 'fr', 'es'];
    const formattedSupportedLanguages = `const ${JSON.stringify(supportedLanguages).replace(/"/g, "'")}`;

    dartContent += `    '${app}': AppThemePalette(
      brightness: ${brightness},
      primary: ${toDartColor(palette.primary.main)},
      primaryContainer: ${toDartColor(palette.primary.light)},
      primaryDark: ${toDartColor(palette.primary.dark)},
      onPrimary: ${toDartColor(palette.primary.contrastText)},
      secondary: ${toDartColor(palette.secondary.main)},
      secondaryContainer: ${toDartColor(palette.secondary.light)},
      secondaryDark: ${toDartColor(palette.secondary.dark)},
      onSecondary: ${toDartColor(palette.secondary.contrastText)},
      background: ${toDartColor(palette.background.default)},
      surface: ${toDartColor(palette.background.paper)},
      textPrimary: ${toDartColor(palette.text.primary)},
      textSecondary: ${toDartColor(palette.text.secondary)},
      textDisabled: ${toDartColor(palette.text.disabled)},
      divider: ${toDartColor(palette.divider)},
      sidebarBackground: ${toDartColor(palette.sidebarBackground)},
      topbarBackground: ${toDartColor(palette.topbarBackground)},
      defaultLanguage: '${defaultLanguage}',
      supportedLanguages: ${formattedSupportedLanguages},
    ),
`;
  }

  // Generate entries for raw presets directly so they can be referenced by name
  for (const [presetName, preset] of Object.entries(presets)) {
    const brightness = preset.mode === 'dark' ? 'Brightness.dark' : 'Brightness.light';
    const defaultLanguage = 'en';
    const supportedLanguages = ['en', 'fr', 'es'];
    const formattedSupportedLanguages = `const ${JSON.stringify(supportedLanguages).replace(/"/g, "'")}`;

    dartContent += `    '${presetName}': AppThemePalette(
      brightness: ${brightness},
      primary: ${toDartColor(preset.primary.main)},
      primaryContainer: ${toDartColor(preset.primary.light)},
      primaryDark: ${toDartColor(preset.primary.dark)},
      onPrimary: ${toDartColor(preset.primary.contrastText)},
      secondary: ${toDartColor(preset.secondary.main)},
      secondaryContainer: ${toDartColor(preset.secondary.light)},
      secondaryDark: ${toDartColor(preset.secondary.dark)},
      onSecondary: ${toDartColor(preset.secondary.contrastText)},
      background: ${toDartColor(preset.background.default)},
      surface: ${toDartColor(preset.background.paper)},
      textPrimary: ${toDartColor(preset.text.primary)},
      textSecondary: ${toDartColor(preset.text.secondary)},
      textDisabled: ${toDartColor(preset.text.disabled)},
      divider: ${toDartColor(preset.divider)},
      sidebarBackground: ${toDartColor(preset.sidebarBackground)},
      topbarBackground: ${toDartColor(preset.topbarBackground)},
      defaultLanguage: '${defaultLanguage}',
      supportedLanguages: ${formattedSupportedLanguages},
    ),
`;
  }

  dartContent += `  };

  static AppThemePalette getAppPalette(String app) {
    return _data[app] ?? const AppThemePalette(
      brightness: Brightness.light,
      primary: Color(0xFF0F766E),
      primaryContainer: Color(0xFFCCFBF1),
      primaryDark: Color(0xFF115E59),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFF0D9488),
      secondaryContainer: Color(0xFF2DD4BF),
      secondaryDark: Color(0xFF0F766E),
      onSecondary: Color(0xFFFFFFFF),
      background: Color(0xFFF0FDFA),
      surface: Color(0xFFFFFFFF),
      textPrimary: Color(0xFF111827),
      textSecondary: Color(0xFF4B5563),
      textDisabled: Color(0xFF9CA3AF),
      divider: Color(0xFFE5E7EB),
      sidebarBackground: Color(0xFF0F766E),
      topbarBackground: Color(0xFF0F766E),
      defaultLanguage: 'en',
      supportedLanguages: ['en', 'fr', 'es'],
    );
  }

  static Color getColor(String app, String key, Color fallback) {
    final palette = getAppPalette(app);
    switch (key) {
      case 'primary': return palette.primary;
      case 'primaryContainer': return palette.primaryContainer;
      case 'primaryDark': return palette.primaryDark;
      case 'onPrimary': return palette.onPrimary;
      case 'secondary': return palette.secondary;
      case 'secondaryContainer': return palette.secondaryContainer;
      case 'secondaryDark': return palette.secondaryDark;
      case 'onSecondary': return palette.onSecondary;
      case 'background': return palette.background;
      case 'surface': return palette.surface;
      case 'textPrimary': return palette.textPrimary;
      case 'textSecondary': return palette.textSecondary;
      case 'textDisabled': return palette.textDisabled;
      case 'divider': return palette.divider;
      case 'sidebarBackground': return palette.sidebarBackground;
      case 'topbarBackground': return palette.topbarBackground;
      default: return fallback;
    }
  }
}
`;

  fs.writeFileSync(outputPath, dartContent, 'utf8');
  console.log(`Generated structured ThemeConfig at ${outputPath}`);
} catch (err) {
  console.error('Error generating ThemeConfig:', err);
  process.exit(1);
}
