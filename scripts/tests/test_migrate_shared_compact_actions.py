import importlib.util
import unittest
from pathlib import Path
s=importlib.util.spec_from_file_location('primary',Path(__file__).parents[1]/'migrate-shared-compact-actions.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
PREFIX="import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"
CALL="TextButton(key: key, onPressed: () => save(record), child: PrimeText('Save'.tr(), style: const TextStyle(fontSize: 11)))"
class MigrationTest(unittest.TestCase):
 def test_preserves_action_key_and_localized_label(self):
  result,count=m.migrate(PREFIX+CALL)
  self.assertEqual(count,1)
  self.assertIn("PrimeButton(key:  key, isGhost: true, label: 'Save'.tr(), onPressed:  () => save(record))",result)
  self.assertEqual(m.migrate(result),(result,0))
 def test_rejects_unsupported_and_ambiguous_sources(self):
  for source in [CALL.replace('fontSize: 11','fontSize: 12'),CALL.replace('fontSize: 11','fontSize: 11, color: Colors.white'),CALL.replace('PrimeText','Text'),CALL.replace('onPressed:', 'onLongPress:'),'class PrimeButton {}'+CALL,'final ctor = TextButton.new;'+CALL,CALL.replace('style: const TextStyle','style: /*keep*/ const TextStyle')]:
   self.assertEqual(m.migrate(PREFIX+source),(PREFIX+source,0))
 def test_does_not_rewrite_comments_or_strings(self):
  source=PREFIX+'// '+CALL+'\nfinal example = "'+CALL+'";'
  self.assertEqual(m.migrate(source),(source,0))

 def test_preserves_complex_callbacks_disabled_state_and_localization(self):
  for callback in ['null', '() async { await save(a, b); setState(() {}); }']:
   source=PREFIX+CALL.replace('() => save(record)',callback)
   result,count=m.migrate(source)
   self.assertEqual(count,1)
   self.assertIn('onPressed:  '+callback,result)
   self.assertIn("label: 'Save'.tr()",result)
 def test_rejects_qualified_calls_restricted_imports_and_duplicate_arguments(self):
  for source in [PREFIX+'ui . '+CALL,PREFIX.replace("primecare_ui.dart';","primecare_ui.dart' show PrimeText;")+CALL,PREFIX+CALL.replace('onPressed:', 'key: extra, onPressed:'),PREFIX+'part of screen;'+CALL]:
   self.assertEqual(m.migrate(source),(source,0))
