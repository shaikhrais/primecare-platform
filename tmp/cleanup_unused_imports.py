import os
from pathlib import Path

def cleanup_unused_imports():
    base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib"
    dart_paths = list(Path(base_dir).rglob("*_stitch.dart"))
    
    count = 0
    for dp in dart_paths:
        with open(dp, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        changed = False
        new_lines = []
        for line in lines:
            if line.strip() == "import 'package:primecare_core/flutter_core.dart';":
                changed = True
                continue
            new_lines.append(line)

        if changed:
            with open(dp, 'w', encoding='utf-8') as f:
                f.writelines(new_lines)
            count += 1
            
    print(f"Removed unused primecare_core imports from {count} stitch files.")

if __name__ == "__main__":
    cleanup_unused_imports()
