import os
import re

ADAPTERS_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\primecare_adapters\lib"

def fix_imports():
    for root, _, files in os.walk(ADAPTERS_DIR):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()

                if 'LocaleKeys.' in content and '.tr()' in content:
                    lines = content.split('\n')
                    has_core = any('package:flutter_core/flutter_core.dart' in l for l in lines)
                    has_keys = any('package:primecare_adapters/primecare_adapters.dart' in l or '00_I_locale_keys.dart' in l for l in lines)
                    
                    changed = False
                    if not has_core:
                        lines.insert(0, "import 'package:flutter_core/flutter_core.dart';")
                        changed = True
                    if not has_keys:
                        lines.insert(0, "import 'package:primecare_adapters/primecare_adapters.dart';")
                        changed = True
                        
                    if changed:
                        with open(path, 'w', encoding='utf-8') as f:
                            f.write('\n'.join(lines))
                        print(f"Fixed imports for {path}")

fix_imports()
