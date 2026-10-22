"""Generate native lifecycle labels from the registered shared surface catalog."""
import json
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
source = json.loads((ROOT / 'packages/shared/src/auth-lifecycle.json').read_text())
registered = json.loads((ROOT / 'tools/governance-production/auth-lifecycle-surface.json').read_text())
if source != registered:
    raise SystemExit('Shared lifecycle catalog differs from registered definition')
def dart(value):
    return json.dumps(value, ensure_ascii=False).replace('$', r'\$')
output = '// Generated from registered auth lifecycle resources; do not edit.\nconst authLifecycleText = <String, Map<String, String>>{\n'
for locale, values in source['locales'].items():
    output += '  ' + dart(locale) + ': {\n'
    output += ''.join('    ' + dart(key) + ': ' + dart(value) + ',\n' for key, value in values.items())
    output += '  },\n'
output += '};\n'
(ROOT / 'packages/primecare_ui/lib/src/features/auth/auth_lifecycle_catalog.g.dart').write_text(output)
