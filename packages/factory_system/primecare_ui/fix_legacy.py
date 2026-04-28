import re

with open('lib/src/shared/src/legacy_bridge.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("RpnProvider", "Provider")

with open('lib/src/shared/src/legacy_bridge.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Replaced RpnProvider with Provider")
