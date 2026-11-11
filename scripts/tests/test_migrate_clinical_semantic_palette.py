import hashlib
import importlib.util
from pathlib import Path
import unittest
import re

ROOT=Path(__file__).resolve().parents[2]
spec=importlib.util.spec_from_file_location('clinical',ROOT/'scripts/migrate-clinical-semantic-palette.py')
m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m)
b=importlib.util.spec_from_file_location('boundary',ROOT/'scripts/check-shared-ui-boundary.py')
boundary=importlib.util.module_from_spec(b);b.loader.exec_module(boundary)


def reverse(current,row):
    positions=[];delta=0
    for edit in row['edits']:
        start=edit['begin']+delta
        assert current[start:start+len(edit['new'])]==edit['new']
        positions.append((start,start+len(edit['new']),edit['old']))
        delta+=len(edit['new'])-(edit['end']-edit['begin'])
    for a,z,value in reversed(positions):current=current[:a]+value+current[z:]
    return current


class ClinicalSemanticPaletteTest(unittest.TestCase):
    def test_every_actual_source_reproduces_original_bytes(self):
        self.assertEqual(len(m.MANIFEST),31)
        self.assertEqual(sum(x['findings'] for x in m.MANIFEST),96)
        for row in m.MANIFEST:
            current=(ROOT/row['path']).read_text();old=reverse(current,row)
            self.assertEqual(hashlib.sha256(old.encode()).hexdigest(),row['sha256'],row['path'])
            self.assertEqual(m.migrate(old),(current,row['findings']))
            self.assertEqual(m.migrate(current),(current,0))
            self.assertEqual(len(boundary.violations(old,False))-len(boundary.violations(current,False)),row['findings'])

    def test_any_source_revision_or_binding_change_is_rejected(self):
        for row in m.MANIFEST:
            current=(ROOT/row['path']).read_text();old=reverse(current,row)
            for changed in [old+'\n',old.replace('context.theme','otherTheme'),old+'\nclass PrimeActionPalette {}\n']:
                self.assertEqual(m.migrate(changed),(changed,0))

    def test_palette_uses_existing_runtime_theme_slots(self):
        theme=(ROOT/'packages/primecare_ui/lib/src/theme/prime_theme.dart').read_text()
        prime_colors=theme.split('class PrimeColors {',1)[1].split('class PrimeTypography',1)[0]
        fields=set(re.findall(r'final Color (\w+)|Color get (\w+)',prime_colors))
        fields={name for pair in fields for name in pair if name}
        palette=(ROOT/'packages/primecare_ui/lib/src/components/prime_action_palette.dart').read_text()
        self.assertTrue(set(re.findall(r'colors\.(\w+)',palette)).issubset(fields))

    def test_business_logic_and_const_preservation(self):
        row=m.MANIFEST[0];current=(ROOT/row['path']).read_text();old=reverse(current,row)
        # The complete edits are restricted to palette expressions, the exact
        # known shadow groups and necessary const keywords. No callback edits.
        for edit in row['edits']:
            if edit['old']=='const':self.assertEqual(edit['new'],'')
            else:
                self.assertTrue(edit['old'].startswith(('Color(', 'Colors.', '[')),edit['old'])
                self.assertNotIn('onPressed',edit['old'])
                self.assertNotIn('onTap',edit['old'])
        for fragment in ['state.activeOutbreaks == 0', 'state.fallsToday == 0',
                         "status == 'Warning'", "label == 'Emergency Alert'",
                         'controller.triggerEmergencyAlert', 'controller.submitIncident']:
            self.assertIn(fragment,old);self.assertIn(fragment,current)


if __name__=='__main__':unittest.main()
