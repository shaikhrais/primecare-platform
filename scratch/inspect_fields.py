import re

gov_file = r"C:\Users\Admin2\Documents\GitHub\primecare-platform\apps\primecare_governance\lib\core\governance\registries\core_governance_registry.dart"

with open(gov_file, 'r', encoding='utf-8') as f:
    content = f.read()

# Find the screens map
map_match = re.search(r'screens\s*=\s*\{(.*?)\};', content, re.DOTALL)
if not map_match:
    print("Could not find screens map!")
    exit(1)

body = map_match.group(1)

# Find all entries
entries = re.findall(r"['\"]([A-Z0-9_]+)['\"]:\s*ScreenMetadata\((.*?)\),", body, re.DOTALL)
print(f"Total screens found: {len(entries)}")

all_keys = set()
for key, meta in entries:
    fields = re.findall(r'(\w+):', meta)
    all_keys.update(fields)

print("Unique fields in ScreenMetadata constructors:")
print(sorted(list(all_keys)))

# Print screens that have implementation-specific details
for key, meta in entries:
    if 'implementedComponents' in meta or 'pendingComponents' in meta or 'completionPercent' in meta or 'office' in meta:
        print(f"\nCustomized Screen: {key}")
        print(meta.strip())
