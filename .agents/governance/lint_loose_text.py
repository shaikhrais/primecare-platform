import os
import re
import sys
import hashlib
import json

# Reconfigure stdout to support unicode printing on Windows terminals
if sys.stdout.encoding != 'utf-8':
    try:
        sys.stdout.reconfigure(encoding='utf-8')
    except AttributeError:
        pass

# Paths to scan
SCAN_PATHS = [
    'packages/primecare_ui/lib',
    'packages/flutter_core/lib'
]

CACHE_FILE = '.agents/governance/.lint_cache'

# Patterns to detect hardcoded strings
PATTERNS = [
    r'Text\(\s*[\'"]([^\'"]+)[\'"]\s*\)',
    r'title:\s*[\'"]([^\'"]+)[\'"]',
]

def get_file_hash(file_path):
    hasher = hashlib.md5()
    with open(file_path, 'rb') as f:
        buf = f.read()
        hasher.update(buf)
    return hasher.hexdigest()

def load_cache():
    if os.path.exists(CACHE_FILE):
        try:
            with open(CACHE_FILE, 'r') as f:
                return json.load(f)
        except:
            return {}
    return {}

def save_cache(cache):
    os.makedirs(os.path.dirname(CACHE_FILE), exist_ok=True)
    with open(CACHE_FILE, 'w') as f:
        json.dump(cache, f, indent=2)

def scan_files(full_scan=False):
    loose_text_found = False
    cache = load_cache()
    new_cache = {}
    
    files_to_scan = []
    
    for path in SCAN_PATHS:
        full_path = os.path.join(os.getcwd(), path)
        if not os.path.exists(full_path):
            continue
            
        for root, dirs, files in os.walk(full_path):
            for file in files:
                if file.endswith('.dart'):
                    file_path = os.path.join(root, file)
                    rel_path = os.path.relpath(file_path, os.getcwd())
                    
                    file_hash = get_file_hash(file_path)
                    
                    if not full_scan and cache.get(rel_path) == file_hash:
                        new_cache[rel_path] = file_hash
                        continue
                    
                    files_to_scan.append((file_path, rel_path, file_hash))

    if not files_to_scan:
        print("Incremental Scan: No changes detected. Platform is compliant.")
        save_cache(new_cache)
        return True

    print(f"Scanning {len(files_to_scan)} changed/new files for Loose Text...")
    
    for file_path, rel_path, file_hash in files_to_scan:
        file_is_clean = True
        with open(file_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            for i, line in enumerate(lines):
                if line.strip().startswith('//') or line.strip().startswith('/*'):
                    continue
                    
                for pattern in PATTERNS:
                    match = re.search(pattern, line)
                    if match:
                        if '.tr()' not in line and 'LocaleKeys.' not in line:
                            loose_text_found = True
                            file_is_clean = False
                            print(f"LOOSE TEXT: {rel_path}:{i+1} -> {match.group(0)}")
        
        if file_is_clean:
            new_cache[rel_path] = file_hash

    # Merge with existing cache if not full scan
    if not full_scan:
        final_cache = {**cache, **new_cache}
    else:
        final_cache = new_cache
        
    save_cache(final_cache)

    if not loose_text_found:
        print(f"SUCCESS: {len(files_to_scan)} files verified. Zero Loose Text detected.")
        return True
    else:
        print("\nCOMPLIANCE FAILURE: Hardcoded strings detected.")
        print("Solution: Register these strings in SQLite 'pages' table (using feature_cli) and use 'LocaleKeys.key.tr()'")
        return False

if __name__ == "__main__":
    is_full = "--full-scan" in sys.argv
    if scan_files(full_scan=is_full):
        sys.exit(0)
    else:
        sys.exit(1)
