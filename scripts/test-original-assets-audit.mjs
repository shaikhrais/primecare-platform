import {test} from 'node:test';
import assert from 'node:assert/strict';
import {spawnSync} from 'node:child_process';

test('source audit includes literal web consumers without claiming dynamic or runtime adoption',()=>{
  const result=spawnSync('python',['-c',String.raw`
import json,runpy,shutil,subprocess,tempfile
from pathlib import Path
from unittest.mock import patch
source=Path.cwd()
with tempfile.TemporaryDirectory() as temp:
 root=Path(temp)
 for file in ['scripts/audit-original-asset-usage.py','packages/primecare_ui/assets/original/registry.json']:
  p=root/file;p.parent.mkdir(parents=True,exist_ok=True);shutil.copyfile(source/file,p)
 fixtures={
 'apps/portal/view.ts': '''originalAssetElement('calendar',opts); shellIcon("building"); primeCareIcon('phone'); shellIcon(name); originalAssetElement('not-registered',opts);''',
 'apps/portal/tests/view.ts': "shellIcon('phone')",
 'packages/flutter_core/lib/navigation/prime_workspace_navigation.dart': "PrimeOriginalAsset('phone')",
 'packages/flutter_core/lib/data_controls/prime_data_controls.dart': '',
 'scripts/fixture.ts': "shellIcon('phone')"}
 for file,body in fixtures.items():
  p=root/file;p.parent.mkdir(parents=True,exist_ok=True);p.write_text(body)
 with patch.object(subprocess,'check_output',return_value='\n'.join(fixtures)):
  runpy.run_path(str(root/'scripts/audit-original-asset-usage.py'))
 report=json.loads((root/'docs/appearance/original-assets-usage-audit.json').read_text())
 rows=report['sharedWebStaticCallSources']
 assert len(rows)==1,rows
 assert rows[0]['path']=='apps/portal/view.ts'
 calls={c['key']:c for c in rows[0]['calls']}
 assert calls['building']['canonical']=='tenant',calls
 assert calls['calendar']['canonical']=='calendar'
 assert calls['phone']['canonical']=='phone'
 assert calls['not-registered']['canonical'] is None
 assert len(calls)==4
 assert len(rows[0]['sha256'])==64
 assert report['adoptedSharedNativeSources']==[{'path':'packages/flutter_core/lib/navigation/prime_workspace_navigation.dart','keys':['phone']}]
 assert report['allAppMigrationClaimed'] is False
 assert 'not runtime' in report['webInventoryMethod']
 print('WEB_AUDIT_REGRESSION_PASS')
`],{encoding:'utf8'});
  assert.equal(result.status,0,result.stderr+'\n'+result.stdout);
  assert.ok(result.stdout.includes('WEB_AUDIT_REGRESSION_PASS'));
});
