import os

ADAPTERS_DIR = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\primecare_adapters\lib"

def fix_imports():
    for root, _, files in os.walk(ADAPTERS_DIR):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()

                if "import 'package:flutter_core/flutter_core.dart';" in content:
                    new_content = content.replace(
                        "import 'package:flutter_core/flutter_core.dart';", 
                        "import 'package:easy_localization/easy_localization.dart';"
                    )
                    with open(path, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"Fixed {path}")

fix_imports()
