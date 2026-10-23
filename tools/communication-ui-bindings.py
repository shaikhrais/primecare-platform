"""Generate shared Dart UI configuration only from a production-readback receipt."""
import argparse,hashlib,json,re
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1]
SOURCE=ROOT/'tools/governance-production/communication-ui-registration.json'
RECEIPT=ROOT/'docs/business/evidence/communication-ui-registration-20261022.json'
TARGET=ROOT/'packages/flutter_core/lib/communications/communication_workspace_catalog.dart'
def dart(value):
 if isinstance(value,str):return json.dumps(value,ensure_ascii=False).replace('$','\\$')
 if isinstance(value,bool):return str(value).lower()
 if isinstance(value,int):return str(value)
 if isinstance(value,list):return '['+','.join(map(dart,value))+']'
 if isinstance(value,dict):return '{'+','.join(dart(k)+':'+dart(v) for k,v in value.items())+'}'
 raise ValueError('Unsupported Dart catalog type')
def render():
 d=json.loads(SOURCE.read_text());digest=hashlib.sha256(SOURCE.read_bytes()).hexdigest();r=json.loads(RECEIPT.read_text())
 if r.get('definitionSha256')!=digest or r.get('independentReadback') is not True or r.get('authority')!='pinned-production-postgresql' or r.get('activation') is not False:raise ValueError('Current independent production registration receipt required')
 ids={key:c['testId'] for key,c in d['controls'].items()}
 if len(set(ids.values()))!=len(ids) or not all(re.fullmatch('[a-z0-9-]+',v) for v in ids.values()):raise ValueError('Registered unique test identifiers required')
 if set(d['locales'])!={'en','fr','es'} or any(set(v)!=set(d['locales']['en']) for v in d['locales'].values()):raise ValueError('Complete registered locales required')
 if any(type(n)is not int or n<1 for n in d['limits'].values()):raise ValueError('Registered positive limits required')
 return '''// Generated from independently read production UI registration. No grants or activation.
// Source SHA-256: '''+digest+'''
abstract final class CommunicationWorkspaceCatalog {
 static const definitionSha256 = '''+dart(digest)+''';
 static const registrationRun = '''+str(int(r['runId']))+''';
 static const screenIds = <int>'''+dart(sorted(map(int,d['screens'])))+''';
 static const limits = <String,int>'''+dart(d['limits'])+''';
 static const generalReference = '''+dart(d['rules']['generalReference'])+''';
 static const _ids = <String,String>'''+dart(ids)+''';
 static const _labels = <String,Map<String,String>>'''+dart(d['locales'])+''';
 static String id(String key) => _ids[key] ?? (throw ArgumentError('Unregistered communication control'));
 static String text(String language, String key) => (_labels[language.split(RegExp('[-_]')).first] ?? _labels['en']!)[key] ?? (throw ArgumentError('Unregistered communication text'));
}
'''
def preview_limits():
 render() # Require the same independent production receipt before either output.
 d=json.loads(SOURCE.read_text());limits=d['limits']
 return json.dumps({'definitionSha256':hashlib.sha256(SOURCE.read_bytes()).hexdigest(),'maxRawBytes':limits['maxMailTextBytes'],'maxTextBytes':limits['maxMailPreviewBytes'],'maxSubjectLength':limits['maxMailSubject'],'maxHeadersSize':limits['maxMailHeaderBytes'],'maxNestingDepth':limits['maxMailNestingDepth'],'maxPartCount':limits['maxMailParts'],'maxHtmlBytes':limits['maxMailHtmlBytes'],'maxHtmlDepth':limits['maxMailHtmlDepth'],'maxHtmlEvents':limits['maxMailHtmlEvents']},indent=2)+'\n'
PREVIEW_TARGET=ROOT/'packages/shared/src/communications/registered-mail-preview-limits.json'
if __name__=='__main__':
 p=argparse.ArgumentParser();p.add_argument('--generate',action='store_true');args=p.parse_args();content=render()
 if args.generate:TARGET.parent.mkdir(parents=True,exist_ok=True);TARGET.write_text(content)
 elif not TARGET.exists() or TARGET.read_text()!=content:raise SystemExit('Shared communication UI bindings differ from production-readback definition')
 if args.generate:PREVIEW_TARGET.write_text(preview_limits())
 elif not PREVIEW_TARGET.exists() or PREVIEW_TARGET.read_text()!=preview_limits():raise SystemExit('Shared mail preview limits differ from production-readback definition')
 print('Communication UI bindings: registered existing screens/controls, 3 locales; no activation')
