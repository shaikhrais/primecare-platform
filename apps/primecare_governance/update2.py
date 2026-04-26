import re
with open('lib/main.dart', 'r', encoding='utf-8') as f:
  c = f.read()

c = c.replace("import 'package:flutter_core/theme/01_I_app_theme.dart';", "import 'package:flutter_core/theme/01_I_app_theme.dart';\nimport 'package:primecare_ui/primecare_ui.dart';")
c = c.replace("Colors.blue", "PrimeCareColors.skyBlue")
c = c.replace("Colors.green", "PrimeCareColors.emerald")
c = c.replace("Colors.orange", "PrimeCareColors.amber")
c = c.replace("Colors.red", "PrimeCareColors.rose")
c = c.replace("Colors.purple", "PrimeCareColors.purple")

with open('lib/main.dart', 'w', encoding='utf-8') as f:
  f.write(c)
