import importlib.util
import unittest
from pathlib import Path
s=importlib.util.spec_from_file_location('primary',Path(__file__).parents[1]/'migrate-shared-primary.py');m=importlib.util.module_from_spec(s);s.loader.exec_module(m)
PREFIX="import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"
CALL="ElevatedButton(key: key, style: ElevatedButton.styleFrom(backgroundColor: theme.colors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),), onPressed: () => save(record), child: PrimeText('Save'.tr(), style: const TextStyle(color: Colors.white)))"
class MigrationTest(unittest.TestCase):
 def test_preserves_action_key_and_localized_label(self):
  result,count=m.migrate(PREFIX+CALL)
  self.assertEqual(count,1)
  self.assertIn("PrimeButton(key:  key, label: 'Save'.tr(), onPressed:  () => save(record))",result)
  self.assertEqual(m.migrate(result),(result,0))
 def test_rejects_unsupported_and_ambiguous_sources(self):
  for source in [CALL.replace('theme.colors.primary','Colors.red'),CALL.replace('circular(8)','circular(12)'),CALL.replace('Colors.white','Colors.black'),CALL.replace('onPressed:', 'onLongPress:'),'class PrimeButton {}'+CALL,'final ctor = ElevatedButton.new;'+CALL,CALL.replace('style: const TextStyle','style: /*keep*/ const TextStyle')]:
   self.assertEqual(m.migrate(PREFIX+source),(PREFIX+source,0))
 def test_does_not_rewrite_comments_or_strings(self):
  source=PREFIX+'// '+CALL+'\nfinal example = "'+CALL+'";'
  self.assertEqual(m.migrate(source),(source,0))
