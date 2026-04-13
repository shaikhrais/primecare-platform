import re

content = open('packages/flutter_core/lib/adapters/generated_adapters.dart', encoding='utf-8').read()
matches = re.findall(r"dynamicScreenAdapterProvider\('([^']+)'\)", content)

with open('keys.txt', 'w', encoding='utf-8') as f:
    for m in matches:
        f.write(m + '\n')

print(f"Found {len(matches)} keys.")
