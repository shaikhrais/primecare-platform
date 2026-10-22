"""Generate Flutter labels from the registered shared MFA catalog."""
import json
from pathlib import Path
root=Path(__file__).resolve().parents[1]
d=json.loads((root/'packages/shared/src/auth-mfa.json').read_text())['locales']
def dart(s):return "'"+s.replace('\\','\\\\').replace("'","\\'").replace('$','\\$')+"'"
s='// Generated from packages/shared/src/auth-mfa.json; do not edit.\nconst nativeMfaText = <String, Map<String, String>>{\n'
for locale,strings in d.items():
 s+='  '+dart(locale)+': {\n'+''.join('    '+dart(k)+': '+dart(v)+',\n' for k,v in strings.items())+'  },\n'
s+='};\n'
s+='const nativeMfaChallengeLifetimeSeconds = '+str(json.loads((root/'tools/governance-production/mfa-registration.json').read_text())['challenge']['expiresSeconds'])+';\n'
(root/'packages/primecare_ui/lib/src/features/auth/mfa_catalog.g.dart').write_text(s)
