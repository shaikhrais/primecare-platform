import importlib.util
import unittest
from pathlib import Path

spec = importlib.util.spec_from_file_location('migration', Path(__file__).parents[1] / 'migrate-generated-theme.py')
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX = "// Generated directly from SQLite Database (historical)\n"
def screen(body):
 return PREFIX + 'class Screen { Widget buildScreen(BuildContext context, WidgetRef ref) { final theme = context.theme; ' + body + ' } }'

class GeneratedThemeMigrationTest(unittest.TestCase):
 def test_contextual_palette_and_const_ancestors(self):
  source = screen("return const Scaffold(backgroundColor: Color(0xFFF0F9FF), body: Text('Hello', style: TextStyle(color: Color(0xFF0F172A))));")
  result,count = m.migrate(source)
  self.assertEqual(count,2)
  self.assertIn('theme.colors.background',result)
  self.assertIn('theme.colors.onSurface',result)
  self.assertNotIn('const Scaffold',result)
  self.assertEqual(m.migrate(result),(result,0))
 def test_opacity_and_unaffected_const_values_are_preserved(self):
  source=screen('return Column(children: [Container(decoration: BoxDecoration(color: const Color(0xFF0284C7).withOpacity(0.1))), const SizedBox(height: 12)]);')
  result,count=m.migrate(source)
  self.assertEqual(count,1)
  self.assertIn('theme.colors.primary.withOpacity(0.1)',result)
  self.assertIn('const SizedBox(height: 12)',result)
  self.assertNotIn('const theme',result)
 def test_unknown_values_contexts_and_non_template_stay(self):
  for body in ['return Icon(Icons.star, color: Color(0xFF123456));',
               'return Chart(color: Color(0xFF0284C7));',
               'return BoxShadow(color: Colors.black);',
               'return Text(label, style: TextStyle(color: Colors.white));']:
   source=screen(body)
   self.assertEqual(m.migrate(source),(source,0))
  source=screen('return Scaffold(backgroundColor: Color(0xFFF0F9FF));').replace(PREFIX,'')
  self.assertEqual(m.migrate(source),(source,0))
 def test_const_collections_only_lose_required_const(self):
  source=screen('return Column(children: const [Icon(Icons.star, color: Color(0xFF0284C7)), SizedBox(height: 12)]);')
  result,count=m.migrate(source)
  self.assertEqual(count,1)
  self.assertNotIn('children: const',result)
 def test_declarations_missing_binding_and_external_code_stay(self):
  for source in [screen('const tint = Color(0xFF0284C7); return Icon(Icons.star, color: Color(0xFF0284C7));'),
                 screen('return Icon(Icons.star, color: Color(0xFF0284C7));').replace('final theme = context.theme;','')]:
   self.assertEqual(m.migrate(source),(source,0))
  source=screen('return Scaffold(backgroundColor: Color(0xFFF0F9FF));')+' final outside=Color(0xFFF0F9FF);'
  result,count=m.migrate(source)
  self.assertEqual(count,1)
  self.assertTrue(result.endswith('final outside=Color(0xFFF0F9FF);'))
 def test_shadowed_theme_and_unmatched_button_background_stay(self):
  source=screen('final theme = other; return Scaffold(backgroundColor: Color(0xFFF0F9FF));')
  self.assertEqual(m.migrate(source),(source,0))
  source=screen("return ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF123456)), child: Text('Go', style: TextStyle(color: Colors.white)));")
  self.assertEqual(m.migrate(source),(source,0))
 def test_comments_and_strings_preserved(self):
  source=screen('final example = "Scaffold(backgroundColor: Color(0xFFF0F9FF))"; /* Color(0xFF0284C7) */ return null;')
  self.assertEqual(m.migrate(source),(source,0))
 def test_button_foreground_and_surface_roles_are_contextual(self):
  source=screen("return ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0284C7)), onPressed: go, child: const Text('Go', style: TextStyle(color: Colors.white)));")
  result,count=m.migrate(source)
  self.assertEqual(count,2)
  self.assertIn('theme.colors.primary',result)
  self.assertIn('theme.colors.onPrimary',result)
