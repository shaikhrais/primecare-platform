import os
import re

SCREEN_ROOT = r'c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\factory_system\primecare_ui\lib\src\screens\offices'

def scan_screens():
    matrix = []
    for root, dirs, files in os.walk(SCREEN_ROOT):
        for file in files:
            if file.endswith('.dart'):
                path = os.path.join(root, file)
                with open(path, 'r', encoding='utf-8') as f:
                    content = f.read()
                    # Find provider usage
                    provider_match = re.search(r'ref\.watch\((.*?)\)', content)
                    provider = provider_match.group(1) if provider_match else 'Unknown'
                    
                    # Check if already refactored
                    is_refactored = 'PageTemplate.orchestrate' in content
                    
                    # Check for "loose code" indicators
                    has_manual_build = 'metricsAsyncValue.when' in content or 'data: (' in content
                    
                    matrix.append({
                        'file': file,
                        'path': path,
                        'provider': provider.strip(),
                        'refactored': is_refactored,
                        'has_loose_code': has_manual_build
                    })
    return matrix

if __name__ == "__main__":
    results = scan_screens()
    print(f"Found {len(results)} screens.")
    for r in results:
        if not r['refactored']:
            print(f"[LEGACY] {r['file']} -> Provider: {r['provider']}")
        elif r['has_loose_code']:
             print(f"[REFACTORED BUT DIRTY] {r['file']}")
