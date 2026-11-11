import importlib.util
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('layout', ROOT/'scripts/migrate-premium-health-layout.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
BEFORE = (ROOT/'scripts/tests/fixtures/premium-health-layout-before.dart').read_text()

class LayoutMigrationTest(unittest.TestCase):
    def test_exact_template_retains_all_text_and_style_expressions(self):
        result, count = m.migrate(BEFORE)
        self.assertEqual(count, 1)
        self.assertEqual(result.count('Expanded(child:'), 3)
        self.assertEqual(result.count('Flexible(child:'), 2)
        # Reverse the five wrappers and two gap edits to recover every byte.
        recovered = result
        for wrapper in ('Expanded', 'Flexible'):
            while wrapper+'(child: ' in recovered:
                start = recovered.index(wrapper+'(child: ')
                code = m.b.text.boundary.executable_code(recovered)
                opening = recovered.index('(', start)
                closing = m.b.arguments(code, opening+1)[1]
                recovered = recovered[:start]+recovered[opening+len('(child: '):closing]+recovered[closing+1:]
        recovered = recovered.replace("const SizedBox(width: 12),\n                      Text(data.isEmpty", "Text(data.isEmpty")
        # Only the telemetry row's former spacer becomes a fixed gap.
        head, row = recovered.split('class _TelemetryRow ', 1)
        at = row.index('const SizedBox(width: 12),', row.index('Text(\n          label,'))
        row = row[:at]+row[at:].replace('const SizedBox(width: 12),','const Spacer(),',1)
        self.assertEqual(head+'class _TelemetryRow '+row, BEFORE)
        self.assertEqual(m.migrate(result), (result, 0))

    def test_changed_templates_and_owners_are_not_guessed(self):
        for old,new in [('Offline','Disconnected'),('width: 14','width: 15'),('const Spacer()','Spacer()'),
                        ('class _TelemetryPanel ', 'class CustomPanel '),('class _TelemetryRow ','class CustomRow '),
                        ('theme.colors.success','Colors.green'),('final theme = context.theme;', 'final theme = other;')]:
            source=BEFORE.replace(old,new)
            self.assertEqual(m.migrate(source),(source,0))

    def test_parts_shadows_and_restricted_imports_remain(self):
        for source in ["part 'other.dart';\n"+BEFORE, BEFORE+'class Expanded {}',
                       BEFORE.replace("primecare_ui.dart';", "primecare_ui.dart' hide Expanded;")]:
            self.assertEqual(m.migrate(source),(source,0))

    def test_fixture_and_all_consumers_match_migrated_helpers(self):
        expected,_ = m.migrate(BEFORE)
        panel=expected[expected.index('class _TelemetryPanel '):expected.index('\nclass _AuditPanel')].strip()
        row=expected[expected.index('class _TelemetryRow '):expected.index('\nclass _StatusBadge')].strip()
        spec = importlib.util.spec_from_file_location('telemetry', ROOT/'scripts/migrate-premium-telemetry-rows.py')
        telemetry = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(telemetry)
        # Preserve the historical responsive repair contract before consolidation.
        self.assertEqual(telemetry.OLD[:telemetry.OLD.index('class _AuditPanel ')].strip(), panel)
        self.assertEqual(telemetry.OLD[telemetry.OLD.index('class _TelemetryRow '):].strip(), row)
        panel = telemetry.NEW[:telemetry.NEW.index('class _AuditPanel ')].strip()
        shared = (ROOT/'packages/primecare_ui/lib/src/components/prime_telemetry_row.dart').read_text()
        expected_row = row.replace('_TelemetryRow', 'PrimeTelemetryRow').replace('Icon(icon,', 'PrimeIcon(icon,').replace('child: Text(', 'child: PrimeText(')
        self.assertEqual(shared[shared.index('class PrimeTelemetryRow '):].strip(), expected_row)
        fixture=(ROOT/'packages/primecare_ui/test/fixtures/premium_health_panel_fixture.dart').read_text().replace('PremiumHealthPanelFixture','_TelemetryPanel')
        self.assertEqual(fixture[fixture.index('class _TelemetryPanel '):].strip(), panel)
        files=list((ROOT/'packages/primecare_ui/lib/src/features/generated_screens').glob('premium_feature_*.dart'))
        self.assertEqual(len(files),251)
        for path in files:
            source=path.read_text()
            self.assertEqual(source[source.index('class _TelemetryPanel '):source.index('class _AuditPanel ')].strip(),panel,path.name)
            self.assertNotIn('class _TelemetryRow ', source, path.name)
