import copy,hashlib,importlib.util,tempfile,unittest
from pathlib import Path
from unittest.mock import patch
ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('audit',ROOT/'scripts/audit-shared-skeleton-equivalents.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)

class SharedSkeletonSourceTests(unittest.TestCase):
 def test_all_current_public_apis_preserve_historical_catalogue_and_acceptance(self):
  path=ROOT/'packages/primecare_ui/catalogs/developer-catalogue.json';before=hashlib.sha256(path.read_bytes()).hexdigest()
  report=m.render();self.assertEqual(len(m.MAPPINGS),24);self.assertIn('50/72 features now have source mappings',report)
  self.assertIn('22 still need reconciliation',report);self.assertIn('All 72 tracked features remain pending',report)
  self.assertEqual(hashlib.sha256(path.read_bytes()).hexdigest(),before)
 def test_unknown_duplicate_missing_and_authority_claims_are_rejected(self):
  mutations=[lambda rows:rows.append(copy.deepcopy(rows[0])),lambda rows:rows[0].update(id='unregistered.capability'),
   lambda rows:rows[0].update(runtimeVerified=True),lambda rows:rows[0]['web'].update(api='class MissingSharedApi '),
   lambda rows:rows[0]['native']['exports'][0].update(target='package:flutter_core/not-the-public-api.dart'),
   lambda rows:rows[0]['web'].update(entry='apps/consumer/local-copy.ts'),
   lambda rows:rows[0]['web'].update(path='../outside.ts'),lambda rows:rows[0]['native'].update(exports=[]),
   lambda rows:rows[0]['native']['exports'].reverse(),
   lambda rows:rows[0]['native']['exports'].pop(),
   lambda rows:rows[0]['native'].update(path='packages/flutter_core/lib/work_modules/prime_work_module.dart',api='class PrimeWorkModule ')]
  for mutate in mutations:
   rows=copy.deepcopy(m.MAPPINGS);mutate(rows)
   with patch.object(m,'MAPPINGS',rows):
    with self.assertRaises(ValueError):m.render()
 def test_commented_api_or_export_cannot_stand_in_for_an_implementation(self):
  evidence=m.MAPPINGS[0]['native'];real=m.source
  for target in [evidence['path'],evidence['exports'][0]['path']]:
   def commented(root,path):
    value=real(root,path)
    return '/*\n'+value+'\n*/' if path==target else value
   with patch.object(m,'source',side_effect=commented):
    with self.assertRaises(ValueError):m.public_api(ROOT,evidence)
 def test_source_symlink_cannot_escape_the_repository(self):
  with tempfile.TemporaryDirectory() as root,tempfile.TemporaryDirectory() as outside:
   target=Path(outside)/'api.ts';target.write_text('export class StaleApi {}')
   Path(root,'api.ts').symlink_to(target)
   with self.assertRaisesRegex(ValueError,'escapes repository'):m.source(Path(root),'api.ts')

if __name__=='__main__':unittest.main()
