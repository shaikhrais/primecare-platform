import re
with open('lib/main.dart', 'r', encoding='utf-8') as f:
  c = f.read()

c = c.replace("import 'screens/governance/governance_data_entry_screen.dart';", "import 'screens/governance/governance_data_entry_screen.dart';\nimport 'package:flutter_core/theme/01_I_app_theme.dart';")
c = c.replace('ThemeData(\n        useMaterial3: true,\n        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),\n        scaffoldBackgroundColor: Colors.grey,\n        fontFamily: \'Roboto\',\n      )', 'AppTheme.lightTheme')

c = c.replace("Container(\n            width: 280,\n            color: Colors.grey,", "Container(\n            width: 280,\n            color: AppTheme.primary,")
c = c.replace("color: Colors.white,\n                    fontSize: 22,", "color: AppTheme.surface,\n                    fontSize: 22,")
c = c.replace("color: Colors.grey, fontSize: 13", "color: Colors.white70, fontSize: 13")
c = c.replace("border: Border.all(color: Colors.grey),", "border: Border.all(color: AppTheme.border),")
c = c.replace("color: Colors.grey.withValues", "color: Colors.black.withValues")

c = c.replace("color: Colors.grey,\n                              fontWeight: FontWeight.bold,", "color: Colors.white,\n                              fontWeight: FontWeight.bold,")
c = c.replace("color: Colors.grey,\n                            borderRadius: BorderRadius.circular(999),", "color: AppTheme.secondary,\n                            borderRadius: BorderRadius.circular(999),")
c = c.replace("color: Colors.grey,\n                                fontSize: 14,", "color: AppTheme.primary,\n                                fontSize: 14,")
c = c.replace("color: Colors.grey,\n                                fontWeight: FontWeight.bold,", "color: AppTheme.primary,\n                                fontWeight: FontWeight.bold,")
c = c.replace("color: Colors.grey, fontSize: 12", "color: Colors.white54, fontSize: 12")
c = c.replace("color: isActive ? Colors.grey : Colors.transparent,", "color: isActive ? AppTheme.secondary : Colors.transparent,")
c = c.replace("color: isActive ? Colors.white : Colors.grey,", "color: isActive ? Colors.white : Colors.white70,")
c = c.replace("color: Colors.grey, fontSize: 14", "color: AppTheme.secondary, fontSize: 14")
c = c.replace("color: Colors.grey,\n                            fontWeight: FontWeight.bold,", "color: AppTheme.primary,\n                            fontWeight: FontWeight.bold,")
c = c.replace("color: Colors.grey,\n        borderRadius: BorderRadius.circular(12),", "color: AppTheme.background,\n        borderRadius: BorderRadius.circular(12),\n        border: Border.all(color: AppTheme.border),")
c = c.replace("color: Colors.grey,\n          fontWeight: FontWeight.w800,", "color: AppTheme.primary,\n          fontWeight: FontWeight.w800,")
c = c.replace("color: Colors.grey,\n                                fontSize: 13,", "color: AppTheme.secondary,\n                                fontSize: 13,")
c = c.replace("color: Colors.grey,\n        borderRadius: BorderRadius.circular(12),\n        border: Border.all(color: Colors.grey, style: BorderStyle.solid),", "color: AppTheme.background,\n        borderRadius: BorderRadius.circular(12),\n        border: Border.all(color: AppTheme.border, style: BorderStyle.solid),")
c = c.replace("color: Colors.white,\n                borderRadius: BorderRadius.circular(10),\n                border: Border.all(color: Colors.grey),", "color: Colors.white,\n                borderRadius: BorderRadius.circular(10),\n                border: Border.all(color: AppTheme.border),")

c = c.replace("color: Colors.grey,\n                          fontSize: 13,\n                          fontWeight: FontWeight.bold,", "color: AppTheme.primary,\n                          fontSize: 13,\n                          fontWeight: FontWeight.bold,")

with open('lib/main.dart', 'w', encoding='utf-8') as f:
  f.write(c)
