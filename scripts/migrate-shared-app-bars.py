#!/usr/bin/env python3
"""Migrate exact reviewed AppBar consumers to PrimeAppBar."""
import argparse,hashlib,json,re
from pathlib import Path
SPECS={
 'apps/primecare_governance/lib/core/governance/route_registry.dart':('099ee2f7763edeb3f8a1b8676e2a5f9e32c40d38b5720a2c60024ffeab55c1f2',1,None),
 'apps/primecare_clinic/lib/features/generated_screens/intake_coordinator_referrals_screen.dart':('ad98d10bc7a08c94c80f8ae9631023672634188ee973308a77f592dd4b213d18',1,None),
 'apps/primecare_clinic/lib/features/generated_screens/psw_incident_report_screen.dart':('e6d545aded4eac50157b765ba711af8356f429667db385e0e7673a72fc127a31',1,None),
 'apps/primecare_clinic/lib/features/generated_screens/caregiver_dashboard_screen.dart':('001bed6e6b9c65b95f9437a54b2b2c121542b4abc25e4aaf77bcacf6655eb541',1,None),
 'apps/primecare_clinic/lib/features/generated_screens/rpn_dashboard_screen.dart':('cca7c1b4251ea011aa6e78024622b2d6d8820c374bcca5c1c2c45d87e6bd698d',1,None),
 'apps/primecare_clinic/lib/features/physician/screens/physician_dashboard_screen.dart':('21a4b6f74c8fd76a56e62ea3e9147c09122c9574ff5907e2dc31b936503e163d',1,None),
 'apps/primecare_enterprise_blueprint/lib/main.dart':('7fc9e953d5b1a85fa477736d52f88298eb13e474028eb99edbe24b8bf03f9af7',1,'ui'),
 'packages/flutter_core/lib/widgets/clinical_article_detail_dialog.dart':('64858cdcfb8a91af5c525758ff156d4885b971c53527acad0b5f594735e76460',1,'foundation'),
 'packages/flutter_core/lib/routes/sso_redirect_view.dart':('19041db1fe17fee4a37d8d77a66cbbe15ba2893995139f3891ddf3c19b4f4d17',1,'foundation'),
 'packages/flutter_core/lib/routes/governance_router.dart':('2256e0f0be42f52a03d3d5e1239a0e16fbbb837c80129ef544b26017abcc1a3b',1,'foundation'),
 'packages/flutter_core/lib/registry/widgets/governance_master_layout.dart':('4f0249a6007a436e6482098599393114280536cb1a7910567dcc58a7031b0f5f',1,'foundation'),
}
CALL=re.compile(r'(?<![\w.])AppBar(?P<space>\s*)\(');SHARED_CALL=re.compile(r'(?<![\w.])PrimeAppBar(?P<space>\s*)\(')
IMPORTS={'foundation':"import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeAppBar;\n",'ui':"import 'package:primecare_ui/primecare_ui.dart' show PrimeAppBar;\n"}
def _insert_import(source,line):
 if line in source:return source
 match=re.search(r'^import ',source,re.MULTILINE)
 if match is None:raise ValueError('reviewed source has no import anchor')
 return source[:match.start()]+line+source[match.start():]
def migrate_source(path,source):
 spec=SPECS.get(path)
 if spec is None or hashlib.sha256(source.encode()).hexdigest()!=spec[0]:return source,0
 updated,count=CALL.subn(lambda m:'PrimeAppBar'+m.group('space')+'(',source)
 if count!=spec[1]:return source,0
 if spec[2]:updated=_insert_import(updated,IMPORTS[spec[2]])
 return updated,count
def reverse_source(path,source):
 spec=SPECS.get(path)
 if spec is None:return source,0
 original,count=SHARED_CALL.subn(lambda m:'AppBar'+m.group('space')+'(',source)
 if count!=spec[1]:return source,0
 if spec[2]:
  line=IMPORTS[spec[2]]
  if original.count(line)!=1:return source,0
  original=original.replace(line,'',1)
 if hashlib.sha256(original.encode()).hexdigest()!=spec[0]:return source,0
 return original,count
def main():
 p=argparse.ArgumentParser(description=__doc__);p.add_argument('--root',type=Path,default=Path(__file__).resolve().parents[1]);p.add_argument('--offset',type=int,default=0);p.add_argument('--limit',type=int,default=len(SPECS));p.add_argument('--apply',action='store_true');a=p.parse_args()
 if a.offset<0 or a.limit<1:p.error('offset must be nonnegative and limit positive')
 root=a.root.resolve();files=[];calls=0
 for relative in list(SPECS)[a.offset:a.offset+a.limit]:
  path=root/relative
  if path.is_symlink() or not path.is_file() or not path.resolve().is_relative_to(root):continue
  updated,count=migrate_source(relative,path.read_text())
  if not count:continue
  if a.apply:path.write_text(updated)
  files.append(relative);calls+=count
 print(json.dumps({'applied':a.apply,'calls':calls,'files':files},indent=2))
if __name__=='__main__':main()
