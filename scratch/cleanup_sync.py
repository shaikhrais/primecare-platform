import glob
import re
import os

# Find all main.dart files in apps
main_files = glob.glob("apps/*/lib/main.dart")

target_patterns = [
    # Pattern with lambda for context.setLocale
    r"\s*// Sync languageProvider with EasyLocalization\s+final langCode = ref\.watch\(languageProvider\);\s+if \(context\.locale\.languageCode != langCode\) \{\s+Future\.microtask\(\(\) => context\.setLocale\(Locale\(langCode\)\)\);\s+\}",
    # Pattern with block/curly braces and mounted check (like in auth)
    r"\s*// Sync languageProvider with EasyLocalization\s+final langCode = ref\.watch\(languageProvider\);\s+if \(context\.locale\.languageCode != langCode\) \{\s+Future\.microtask\(\(\) \{\s+if \(!context\.mounted\) return;\s+context\.setLocale\(Locale\(langCode\)\);\s+\}\);\s+\}"
]

for file_path in main_files:
    if not os.path.exists(file_path):
        continue
        
    print(f"Checking {file_path}...")
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
        
    original = content
    for pattern in target_patterns:
        content = re.sub(pattern, "", content)
        
    if content != original:
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"  -> Cleaned up redundant sync block in {file_path}")
    else:
        print(f"  -> No match found in {file_path}")
