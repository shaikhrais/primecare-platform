"""Generate native Dart routes only from independently verified access metadata."""
import hashlib,json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
def render():
 definition=ROOT/'tools/governance-production/voice-contact-access-registration.json';d=json.loads(definition.read_text())
 r=json.loads((ROOT/'docs/business/evidence/voice-contact-access-registration-20261024.json').read_text())
 if r.get('authority')!='pinned-production-postgresql' or r.get('independentReadback') is not True or r.get('activation') is not False or r.get('definitionSha256')!=hashlib.sha256(definition.read_bytes()).hexdigest():raise ValueError('Independent current native access receipt required')
 c=json.loads((ROOT/'tools/governance-production/voice-contact-contracts-registration.json').read_text());pin=json.loads((ROOT/'tools/governance-production/production-pin.json').read_text())
 if hashlib.sha256((ROOT/'tools/governance-production/voice-contact-contracts-registration.json').read_bytes()).hexdigest()!=pin['voiceContactRegistrationWriter']['definitionSha256']:raise ValueError('Pinned native contracts required')
 lines=['// Generated from pinned production native access readback; no live activation.',"import 'dio_communication_transport.dart';",'final registeredVoiceContactBindings = Map<String,CommunicationRouteBinding>.unmodifiable({']
 if len(c['operations'])!=3 or set(d['apiIds'])!={o['key'] for o in c['operations']}:raise ValueError('Exact three native contracts required')
 for op in c['operations']:
  if op['authentication']!='native-session-csrf' or op['method']!='POST':raise ValueError('Native POST contracts required')
  key='voiceContact.'+op['key'].split('.')[1]
  lines.append(f" '{key}':CommunicationRouteBinding(path:'{op['path']}',method:'POST',includeAction:false), // API{d['apiIds'][op['key']]}")
 return '\n'.join([*lines,'});',''])
if __name__=='__main__':
 p=ROOT/'packages/flutter_core/lib/communications/registered_voice_contact_bindings.dart';s=render()
 if sys.argv[1:]==['--generate']:p.write_text(s)
 elif sys.argv[1:] or not p.exists() or p.read_text()!=s:raise SystemExit('Native phone client routes differ from current production readback')
 print('Three registered native phone enrollment routes checked; no activation')
