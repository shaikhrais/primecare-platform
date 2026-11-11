import importlib.util
import unittest
from pathlib import Path
spec = importlib.util.spec_from_file_location('m', Path(__file__).parents[1] / 'migrate-premium-progress.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX="import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\nclass PremiumFeature1 extends GovernedConsumerWidget {}\n"
CALL='LinearProgressIndicator(value: progress, backgroundColor: Colors.grey.shade200, valueColor: animation, minHeight: 8)'
def panel(call):
    return PREFIX+'class _TelemetryPanel extends StatelessWidget { Widget build(BuildContext context) { return '+call+'; } }'

class ProgressMigrationTests(unittest.TestCase):
    def test_preserves_progress_foreground_and_height(self):
        source=panel(CALL)
        result,count=m.migrate(source)
        self.assertEqual(count,1)
        self.assertEqual(result,source.replace('LinearProgressIndicator(', 'PrimeLinearProgressIndicator(').replace(' backgroundColor: Colors.grey.shade200,',''))
        self.assertEqual(m.migrate(result),(result,0))

    def test_final_field_trailing_comma_and_const_parents_are_retained(self):
        for suffix in [')',',)']:
            call='const LinearProgressIndicator(value: .4, valueColor: animation, minHeight: 8, backgroundColor: Colors.grey.shade200'+suffix
            result,count=m.migrate(panel(call))
            self.assertEqual(count,1)
            self.assertIn('const PrimeLinearProgressIndicator',result)
            self.assertNotIn(',,',result)
            self.assertEqual(m.migrate(result),(result,0))

    def test_other_owner_track_color_or_options_stay(self):
        for source in [panel(CALL).replace('_TelemetryPanel','_ChartPanel'),
                       panel(CALL.replace('shade200','shade300')),
                       panel(CALL.replace('minHeight: 8','minHeight: 8, semanticsLabel: label')),
                       panel(CALL.replace('backgroundColor:', 'backgroundColor: /*retain*/')),
                       panel('custom.'+CALL)]:
            self.assertEqual(m.migrate(source),(source,0))

    def test_comments_strings_concrete_types_and_shadowed_symbols_stay(self):
        for source in [panel('null')+'// '+CALL,
                       panel('null')+'final sample="'+CALL+'";',
                       panel(CALL)+'class Colors {}',
                       panel(CALL)+'final List<LinearProgressIndicator> indicators=[];',
                       panel(CALL)+'final ctor=LinearProgressIndicator.new;',
                       panel(CALL).replace("primecare_ui.dart';", "primecare_ui.dart' show PrimeText;")]:
            self.assertEqual(m.migrate(source),(source,0))
