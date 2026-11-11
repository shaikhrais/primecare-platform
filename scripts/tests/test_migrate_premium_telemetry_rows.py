import importlib.util
import unittest
from pathlib import Path
sp=importlib.util.spec_from_file_location('tr',Path(__file__).parents[1]/'migrate-premium-telemetry-rows.py');m=importlib.util.module_from_spec(sp);sp.loader.exec_module(m)
PREFIX="import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\nclass PremiumFeature1 extends GovernedConsumerWidget {}\n"
class TelemetryRowsTest(unittest.TestCase):
 def test_exact_block_moves_six_calls_and_removes_duplicate_renderer(self):
  source=PREFIX+m.OLD
  updated,count=m.migrate(source)
  self.assertEqual(count,6)
  self.assertEqual(updated,PREFIX+m.NEW)
  self.assertEqual(updated.count('PrimeTelemetryRow('),6)
  self.assertNotIn('class _TelemetryRow',updated)
  self.assertEqual(m.migrate(updated),(updated,0))
 def test_modified_panels_and_renderer_are_rejected(self):
  for old,new in [('Sync Frequency','Other label'),('0.0034 delta','other'),('Colors.indigo','Colors.blue'),('fontSize: 13.5','fontSize: 12'),('final theme = context.theme;','final theme = other;')]:
   source=PREFIX+m.OLD.replace(old,new)
   self.assertEqual(m.migrate(source),(source,0))
 def test_parts_restricted_imports_and_shadowing_are_rejected(self):
  source=PREFIX+m.OLD
  for changed in ["part 'other.dart';"+source,source+'class PrimeTelemetryRow {}',source+'Widget PrimeTelemetryRow() => other;',source.replace("primecare_ui.dart';","primecare_ui.dart' show PrimeText;"),source.replace('PremiumFeature1','OtherFeature')]:
   self.assertEqual(m.migrate(changed),(changed,0))
 def test_comments_and_strings_do_not_become_components(self):
  for source in [PREFIX+'/*'+m.OLD+'*/',PREFIX+'final example = r"""'+m.OLD+'""";']:
   self.assertEqual(m.migrate(source),(source,0))
