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

 def test_role_palettes_share_theme_and_button_foreground(self):
  for accent, background in [('E11D48','FFF1F2'),('2563EB','EFF6FF'),('059669','F0FDF4'),('7C3AED','F5F3FF'),('D97706','FFFBEB')]:
   source=screen("return Scaffold(backgroundColor: Color(0xFF"+background+"), body: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF"+accent+")), child: const Text('Go', style: TextStyle(color: Colors.white))));")
   result,count=m.migrate(source)
   self.assertEqual(count,3)
   self.assertIn('theme.colors.background',result)
   self.assertIn('theme.colors.primary',result)
   self.assertIn('theme.colors.onPrimary',result)
   self.assertEqual(m.migrate(result),(result,0))

 def test_inverse_panel_uses_paired_foreground_only_within_its_container(self):
  source=screen("return Column(children: [Container(decoration: BoxDecoration(color: const Color(0xFF0F172A)), child: const Column(children: [Text('Audit', style: TextStyle(color: Colors.white)), Text('API', style: TextStyle(color: Color(0xFF94A3B8))), Text('Selector', style: TextStyle(color: Color(0xFF34D399))), Text('Accessibility', style: TextStyle(color: Color(0xFF60A5FA)))])), const Text('Outside', style: TextStyle(color: Colors.white))]);")
  result,count=m.migrate(source)
  self.assertEqual(count,5)
  self.assertEqual(result.count('theme.colors.inverseOnSurface'),4)
  self.assertIn('theme.colors.inverseSurface',result)
  self.assertIn("const Text('Outside', style: TextStyle(color: Colors.white))",result)
  self.assertNotIn('const Column',result)
  self.assertEqual(m.migrate(result),(result,0))

 def test_nested_panel_does_not_change_outer_sibling_text(self):
  source=screen("return Container(child: Column(children: [const Text('Outer', style: TextStyle(color: Colors.white)), Container(decoration: BoxDecoration(color: const Color(0xFF0F172A)), child: Text('Inner', style: TextStyle(color: Colors.white)))]));")
  result,count=m.migrate(source)
  self.assertEqual(count,2)
  self.assertIn("const Text('Outer', style: TextStyle(color: Colors.white))",result)

 def test_exact_shadow_moves_to_shared_elevation_token(self):
  source=screen('return const BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: Offset(0, 4))]);')
  result,count=m.migrate(source)
  self.assertEqual(count,1)
  self.assertIn('boxShadow: theme.shadowsSurface1',result)
  self.assertNotIn('const BoxDecoration',result)
  self.assertEqual(m.migrate(result),(result,0))

 def test_custom_shadows_and_comments_stay(self):
  base='return BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]);'
  for body in [base.replace('10,','12,'),base.replace('0.02','0.2'),base.replace('BoxDecoration','CustomWidget'),base.replace('blurRadius:', '/*keep*/ blurRadius:'),base.replace('offset:', 'spreadRadius: 2, offset:')]:
   source=screen(body)
   self.assertEqual(m.migrate(source),(source,0))

 def test_color_member_prefixes_and_embedded_comments_are_not_rewritten(self):
  for body in ['return Container(decoration: BoxDecoration(color: Colors.white70));', 'return Scaffold(backgroundColor: Color(/*keep*/0xFFF0F9FF));']:
   source=screen(body)
   self.assertEqual(m.migrate(source),(source,0))
