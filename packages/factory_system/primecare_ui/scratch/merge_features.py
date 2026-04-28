import os
import re

base_path = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\features'
view_target = os.path.join(base_path, 'features_view.dart')
controller_target = os.path.join(base_path, 'features_controller.dart')
model_target = os.path.join(base_path, 'features_model.dart')

view_header = """import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_core/flutter_core.dart';
import 'features_controller.dart';
import 'features_model.dart';
"""

controller_header = """import 'package:primecare_ui/primecare_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'features_model.dart';
"""

model_header = """import 'package:primecare_ui/primecare_ui.dart';
"""

def to_pascal_case(s):
    return ''.join(x.capitalize() for x in s.split('_'))

def process_files(suffix, target, header):
    print(f"Processing {suffix} -> {target}")
    content = [header]
    folders = sorted([f for f in os.listdir(base_path) if os.path.isdir(os.path.join(base_path, f))])
    
    for folder in folders:
        folder_path = os.path.join(base_path, folder)
        prefix = to_pascal_case(folder)
        
        try:
            for filename in os.listdir(folder_path):
                if filename.endswith(f"_{suffix}.dart"):
                    file_path = os.path.join(folder_path, filename)
                    with open(file_path, 'r', encoding='utf-8') as f:
                        text = f.read()
                    
                    # Strip imports
                    text = re.sub(r'^import\s+.*;$', '', text, flags=re.MULTILINE)
                    text = re.sub(r'^export\s+.*;$', '', text, flags=re.MULTILINE)
                    text = re.sub(r'^part\s+.*;$', '', text, flags=re.MULTILINE)
                    
                    # Rename common collisions
                    # Private classes: _ClassName -> _FolderClassName
                    # We match _ followed by uppercase letter
                    text = re.sub(r'class\s+(_[A-Z][a-zA-Z0-9]*)', f'class _{prefix}\\1', text)
                    text = re.sub(r'extends\s+(_[A-Z][a-zA-Z0-9]*)', f'extends _{prefix}\\1', text)
                    text = re.sub(r'with\s+(_[A-Z][a-zA-Z0-9]*)', f'with _{prefix}\\1', text)
                    # Also need to rename usages like 'return _KpiCard('
                    # This is risky but likely necessary
                    # text = re.sub(r'([^_a-zA-Z0-9])(_[A-Z][a-zA-Z0-9]*)', f'\\1_{prefix}\\2', text)
                    
                    # Specific Public Collisions
                    if suffix == 'view':
                        if folder in ['jwt_auth', 'firebase_auth', 'fuse_auth']:
                            text = text.replace('AuthView', f'{prefix}View')
                            text = text.replace('const AuthView', f'const {prefix}View')
                        
                        # Handle the common _KpiCard etc manually for safer replacement
                        for cls in ['_KpiCard', '_InsightTile', '_ActivityTile']:
                            text = text.replace(cls, f'_{prefix}{cls}')
                    
                    if suffix == 'model':
                        if 'class KpiData' in line if 'line' in locals() else True: # Fix for KpiData
                            text = text.replace('class KpiData', f'class {prefix}KpiData')
                            text = text.replace('KpiData(', f'{prefix}KpiData(')
                    
                    content.append(f"\n// --- Start of {folder}/{filename} ---\n")
                    content.append(text)
                    content.append(f"\n// --- End of {folder}/{filename} ---\n")
        except Exception as e:
            print(f"Error processing folder {folder}: {e}")
                
    with open(target, 'w', encoding='utf-8') as f:
        f.writelines(content)

process_files('view', view_target, view_header)
process_files('controller', controller_target, controller_header)
process_files('model', model_target, model_header)

print("Done!")
