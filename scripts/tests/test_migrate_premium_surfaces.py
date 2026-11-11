import importlib.util
import unittest
from pathlib import Path

spec=importlib.util.spec_from_file_location('premium',Path(__file__).parents[1]/'migrate-premium-surfaces.py')
m=importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
PREFIX="import 'package:flutter/material.dart';\nimport 'package:primecare_ui/primecare_ui.dart';\n"


def screen(body):
    return PREFIX+'class PremiumFeature1 extends GovernedConsumerWidget { Widget buildScreen(BuildContext context, WidgetRef ref) { final theme = context.theme; '+body+' } }'


class PremiumSurfaceMigrationTest(unittest.TestCase):
    def test_premium_brand_pair_follows_active_primary_and_keeps_opacity(self):
        source=screen("return Container(decoration: BoxDecoration(color: const Color(0xFF6366F1).withOpacity(0.1)), child: const Text('PREMIUM', style: TextStyle(color: Color(0xFF6366F1))));")
        result,count=m.migrate(source)
        self.assertEqual(count,2)
        self.assertIn('theme.colors.primary.withOpacity(0.1)',result)
        self.assertIn('TextStyle(color: theme.colors.primary)',result)
        self.assertNotIn('const Text',result)
        self.assertNotIn('const theme',result)
        self.assertEqual(m.migrate(result),(result,0))

    def test_brand_value_does_not_rewrite_chart_or_model_arguments(self):
        for body in ['return Chart(color: Color(0xFF6366F1));',
                     'return _StatCard(color: Color(0xFF6366F1));',
                     'return QuickActionItem(color: Color(0xFF6366F1));']:
            source=screen(body)
            self.assertEqual(m.migrate(source),(source,0))

    def test_exact_hydration_failure_uses_existing_error_role(self):
        source=screen("return Text('Hydration Failure: $error', // retain diagnostic annotation\n style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold));")
        result,count=m.migrate(source)
        self.assertEqual(count,1)
        self.assertIn('color: theme.colors.error',result)
        self.assertIn('// retain diagnostic annotation',result)
        self.assertIn('fontWeight: FontWeight.bold',result)
        self.assertNotIn('const TextStyle',result)
        self.assertEqual(m.migrate(result),(result,0))

    def test_other_red_labels_qualified_text_and_shadowed_symbols_stay(self):
        for body in ["return Text('Decorative', style: TextStyle(color: Colors.red));",
                     "return Text('Hydration Failure: $other', style: TextStyle(color: Colors.red));",
                     "return custom.Text('Hydration Failure: $error', style: TextStyle(color: Colors.red));",
                     "return Text('Hydration Failure: $error', style: TextStyle(color: Colors.red.shade700));",
                     "return Text('Hydration Failure: $error', style: TextStyle(color: Colors.red[700]));"]:
            source=screen(body)
            self.assertEqual(m.migrate(source),(source,0))
        source=screen("return Text('Hydration Failure: $error', style: TextStyle(color: Colors.red));")+'class Text {}'
        self.assertEqual(m.migrate(source),(source,0))

    def test_telemetry_label_uses_muted_surface_role_without_changing_typography(self):
        source=screen('return null;')+'class _TelemetryRow extends StatelessWidget { Widget build(BuildContext context) { final theme = context.theme; return Text(label, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500, color: Colors.blueGrey.shade600)); } }'
        result,count=m.migrate(source)
        self.assertEqual(count,1)
        self.assertIn('fontSize: 13.5, fontWeight: FontWeight.w500, color: theme.colors.onSurfaceVariant',result)
        self.assertNotIn('const TextStyle',result)
        self.assertEqual(m.migrate(result),(result,0))

    def test_telemetry_color_other_shades_and_non_text_contexts_stay(self):
        for body in ['return Text(label, style: TextStyle(color: Colors.blueGrey.shade600));',
                     'return Chart(color: Colors.blueGrey.shade600);',
                     'return Icon(Icons.star, color: Colors.blueGrey.shade600);',
                     'return TextStyle(color: Colors.blueGrey.shade6000);',
                     'return TextStyle(color: Colors.blueGrey.shade700);']:
            source=screen(body)
            self.assertEqual(m.migrate(source),(source,0))

    def test_neutral_palette_uses_contextual_roles_and_is_idempotent(self):
        source=screen('return Scaffold(backgroundColor: const Color(0xFFF8FAFC), appBar: AppBar(backgroundColor: Colors.white, title: const Text("Title", style: TextStyle(color: Color(0xFF0F172A)))));')
        result,count=m.migrate(source)
        self.assertEqual(count,3)
        for role in ['background','surface','onSurface']:
            self.assertIn('theme.colors.'+role,result)
        self.assertNotIn('const Text(',result)
        self.assertEqual(m.migrate(result),(result,0))

    def test_helper_widget_resolves_its_own_inherited_theme(self):
        source=screen('return null;')+'class _StatCard extends StatelessWidget { Widget build(BuildContext context) { return BoxDecoration(color: Colors.white); } }'
        result,count=m.migrate(source)
        self.assertEqual(count,1)
        self.assertEqual(result.count('final theme = context.theme;'),2)
        self.assertEqual(m.migrate(result),(result,0))

    def test_const_collection_and_opacity_remain_valid(self):
        source=screen('return Column(children: const [Icon(Icons.star, color: Color(0xFF64748B))]);')
        result,count=m.migrate(source)
        self.assertEqual(count,1)
        self.assertNotIn('children: const',result)
        source=screen('return BoxDecoration(color: Colors.white.withOpacity(0.5));')
        result,count=m.migrate(source)
        self.assertIn('theme.colors.surface.withOpacity(0.5)',result)

    def test_status_accent_chart_and_unknown_context_stay(self):
        for value in ['Icon(Icons.star, color: Colors.amber)', 'Icon(Icons.star, color: Color(0xFF6366F1))',
                      'Chart(color: Color(0xFF0F172A))', 'TextStyle(color: Colors.blueGrey.shade4000)',
                      'TextStyle(color: Colors.white)']:
            source=screen('return '+value+';')
            self.assertEqual(m.migrate(source),(source,0))

    def test_shadowed_theme_symbols_and_non_template_stay(self):
        for source in [screen('return BoxDecoration(color: Colors.white);').replace('PremiumFeature1','CustomScreen'),
                       screen('final theme = other; return BoxDecoration(color: Colors.white);'),
                       screen('const fill=Colors.white; return BoxDecoration(color: Colors.white);'),
                       screen('return BoxDecoration(color: Colors.white);')+'class Colors {}']:
            self.assertEqual(m.migrate(source),(source,0))

    def test_existing_unbound_theme_is_not_shadowed(self):
        source=screen('final before=theme; return BoxDecoration(color: Colors.white);').replace('final theme = context.theme;','')
        self.assertEqual(m.migrate(source),(source,0))

    def test_comments_strings_and_qualified_contexts_stay(self):
        for body in ['return custom.BoxDecoration(color: Colors.white);',
                     'final sample="TextStyle(color: Colors.white)"; /* BoxDecoration(color: Colors.white) */ return null;']:
            source=screen(body)
            self.assertEqual(m.migrate(source),(source,0))

    def test_nested_build_methods_stay(self):
        source=screen('Widget build(BuildContext context) { return BoxDecoration(color: Colors.white); } return build(context);')
        self.assertEqual(m.migrate(source),(source,0))
