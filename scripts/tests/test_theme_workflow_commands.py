import re,subprocess,unittest
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
class ThemeWorkflowCommandsTest(unittest.TestCase):
 def test_dependency_install_is_not_folded_together_with_test_commands(self):
  text=(ROOT/'.github/workflows/theme-center.yml').read_text();lines=text.splitlines()
  for index,line in enumerate(lines):
   if re.match(r'\s+- run: flutter pub get$',line):
    self.assertRegex(lines[index+1],r'^        working-directory: ')
 def test_shared_test_changes_trigger_full_current_head_validation(self):
  text=(ROOT/'.github/workflows/theme-center.yml').read_text()
  paths=re.findall(r'paths:\s*\[(.*?)\]',text,re.S);self.assertEqual(len(paths),2)
  for event_paths in paths:
   for root in ['packages/flutter_core/test/**','packages/primecare_ui/test/**','packages/primecare_ui_foundation/test/**']:
    self.assertIn("'"+root+"'",event_paths)
   self.assertIn("'.github/workflows/theme-center.yml'",event_paths)
 def test_consumer_compile_script_is_valid_shell_and_contains_each_optional_suite_once(self):
  text=(ROOT/'.github/workflows/theme-center.yml').read_text();start=text.index('      - name: Compile migrated consumer libraries');lines=text[start:].splitlines();run=lines.index('        run: |');script=[]
  for line in lines[run+1:]:
   if line.startswith('        working-directory:'):break
   self.assertTrue(line.startswith('          '));script.append(line[10:])
  command='\n'.join(script)+'\n';result=subprocess.run(['bash','-n'],input=command,text=True,capture_output=True);self.assertEqual(result.returncode,0,result.stderr)
  for filename in ['shared_circular_progress_compile_test.dart','remaining_theme_consumers_compile_test.dart','remaining_theme_widgets_test.dart','remaining_material_controls_compile_test.dart']:
   self.assertEqual(command.count('flutter test test/'+filename),1)
if __name__=='__main__':unittest.main()
