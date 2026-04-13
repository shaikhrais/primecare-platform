import os
import re
from pathlib import Path

def cleanup_unused_imports():
    base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\flutter_core\lib"
    dart_paths = list(Path(base_dir).rglob("*_adapter.dart"))
    
    count = 0
    for dp in dart_paths:
        with open(dp, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            
        new_lines = []
        changed = False
        for line in lines:
            if line.strip() == "import 'dart:convert';" and "json" not in "".join(lines):
                changed = True
                continue
            
            # just blindly rip it out if we don't use jsonEncode or jsonDecode
            # actually dart:convert is rarely used in simple state notifiers.
            if line.strip() == "import 'dart:convert';":
                # Check if it's actually used
                content = "".join(lines)
                if "json.encode" not in content and "json.decode" not in content and "jsonEncode" not in content and "jsonDecode" not in content:
                    changed = True
                    continue
            new_lines.append(line)
            
        if changed:
            with open(dp, 'w', encoding='utf-8') as f:
                f.writelines(new_lines)
            count += 1
            
    print(f"Removed unused dart:convert from {count} files.")

if __name__ == "__main__":
    cleanup_unused_imports()
