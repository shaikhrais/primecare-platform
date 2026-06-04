const fs = require('fs');
const path = require('path');

const rootDir = path.resolve(__dirname, '..');
const jsonPath = path.join(rootDir, 'theme_config.json');
const outputPath = path.join(rootDir, 'packages', 'flutter_core', 'lib', 'theme', 'theme_config_generated.dart');

try {
  const jsonContent = fs.readFileSync(jsonPath, 'utf8');
  const data = JSON.parse(jsonContent);

  let dartContent = `// Generated file. Do not edit directly. Edit theme_config.json in root.
import 'package:flutter/material.dart';

class ThemeConfig {
  static const Map<String, Map<String, String>> _data = {
`;

  for (const [app, colors] of Object.entries(data)) {
    dartContent += `    '${app}': {\n`;
    for (const [key, value] of Object.entries(colors)) {
      dartContent += `      '${key}': '${value}',\n`;
    }
    dartContent += `    },\n`;
  }

  dartContent += `  };

  static Color getColor(String app, String key, Color fallback) {
    final appConfig = _data[app];
    if (appConfig != null && appConfig[key] != null) {
      final hex = appConfig[key]!;
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    }
    return fallback;
  }
}
`;

  fs.writeFileSync(outputPath, dartContent, 'utf8');
  console.log(`Generated ThemeConfig at ${outputPath}`);
} catch (err) {
  console.error('Error generating ThemeConfig:', err);
  process.exit(1);
}
