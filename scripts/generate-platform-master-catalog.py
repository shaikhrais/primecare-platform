"""Reuse registered administration identity and shared localized labels."""
import json
from pathlib import Path

root = Path(__file__).resolve().parents[1]
registry = json.loads((root/'cloudflare/workers/src/workspace-registry.json').read_text())
screens = [s for s in registry['screens'] if s['code'] == 'PLATFORM_ADMINISTRATION']
assert len(screens) == 1 and screens[0]['id'] == 1269
assert screens[0]['route'] == '/platform/administration'
labels = json.loads((root/'cloudflare/workers/src/screen-text-defaults.json').read_text())['platform_administration']
def dart(value):
    return "'"+value.replace('\\','\\\\').replace("'","\\'").replace('$','\\$').replace('\n','\\n')+"'"
source = '// Generated from registered platform administration identity and screen-text defaults.\n'
source += 'const platformAdministrationRoute = '+dart(screens[0]['route'])+';\n'
source += 'const platformAdministrationText = <String, Map<String, String>>{\n'
for locale, values in labels.items():
    source += '  '+dart(locale)+': {\n'
    source += ''.join('    '+dart(key)+': '+dart(value)+',\n' for key,value in values.items())
    source += '  },\n'
source += '};\n'
(root/'packages/primecare_ui/lib/src/features/platform/platform_master_catalog.g.dart').write_text(source)
