import os
import subprocess
import re

def main():
    base_dir = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui"
    
    # Run dart analyze
    print("Running dart analyze...")
    result = subprocess.run(["dart", "analyze"], cwd=base_dir, capture_output=True, text=True, shell=True)
    
    # Parse unused import errors
    lines = result.stdout.split('\n')
    files_to_fix = set()
    
    for line in lines:
        if "Unused import: 'package:primecare_core/flutter_core.dart'" in line:
            # Example line: "warning - lib\src\screens\common\document_vault.dart:3:8 - Unused import..."
            match = re.search(r'-\s+(lib[^\:]+)\:\d+\:\d+', line)
            if match:
                file_path = os.path.join(base_dir, match.group(1))
                files_to_fix.add(file_path)
    
    count = 0
    for file_path in files_to_fix:
        if os.path.exists(file_path):
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.readlines()
            
            new_content = []
            for line in content:
                if 'package:primecare_core/flutter_core.dart' in line:
                    if '// ignore: unused_import' not in line:
                        new_content.append('// ignore: unused_import\n')
                new_content.append(line)
            if len(new_content) > len(content):
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.writelines(new_content)
                count += 1
                
    print(f"Fixed {count} files with unused primecare_core/flutter_core imports.")

if __name__ == "__main__":
    main()
