"""Generate native support resources and core constants from the registered surface."""
import json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
d=json.loads((ROOT/'packages/shared/src/auth-elevation.json').read_text())
if d!=json.loads((ROOT/'tools/governance-production/auth-elevation-surface.json').read_text()):raise SystemExit('Shared elevation catalog differs from registered source')
def dart(value):return json.dumps(value,ensure_ascii=False).replace('$',r'\$')
s='// Generated from registered elevation resources; do not edit.\nconst authElevationText = <String, Map<String, String>>{\n'
for locale,values in d['locales'].items():
 s+='  '+dart(locale)+': {\n'+''.join('    '+dart(key)+': '+dart(value)+',\n' for key,value in values.items())+'  },\n'
s+='};\n';(ROOT/'packages/primecare_ui/lib/src/features/auth/auth_elevation_catalog.g.dart').write_text(s)
keys={'auth_elevation':'elevate','auth_elevation_revoke':'revokeElevation','auth_support_request':'requestSupport','auth_support_requests':'listSupport','auth_support_approve':'approveSupport','auth_support_revoke':'revokeSupport','auth_support_summary':'summary'}
assert {e['code'] for e in d['endpoints']}==set(keys)
s='// Generated from registered elevation contracts; do not edit.\nconst temporaryAccessMaximumSeconds = '+str(d['maximumSeconds'])+';\nconst temporaryAccessAction = '+dart(d['action'])+';\nconst privilegedAccessEndpoints = <String, String>{\n'+''.join('  '+dart(keys[e['code']])+': '+dart(e['route'])+',\n' for e in d['endpoints'])+'};\n';(ROOT/'packages/flutter_core/lib/src/application/privileged_access_contract.g.dart').write_text(s)
