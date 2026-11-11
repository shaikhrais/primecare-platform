import importlib.util
import unittest
import tempfile
from pathlib import Path

spec = importlib.util.spec_from_file_location('boundary', Path(__file__).parents[1] / 'check-shared-ui-boundary.py')
boundary = importlib.util.module_from_spec(spec)
spec.loader.exec_module(boundary)

class SharedUiBoundaryTest(unittest.TestCase):
    def test_icons_and_progress_controls_require_shared_library(self):
        source = 'Icon(Icons.star); CircularProgressIndicator(); LinearProgressIndicator(value: progress);'
        self.assertEqual([f[2] for f in boundary.violations(source, True)],
                         ['Icon', 'CircularProgressIndicator', 'LinearProgressIndicator'])
        self.assertEqual(boundary.violations(source, False), [])

    def test_executable_string_interpolations_are_checked(self):
        source = 'final label = "value ${Text(\"inside\").data} ${Colors.red}";'
        self.assertEqual([f[2] for f in boundary.violations(source, True)], ['Text', 'Colors.red'])

    def test_nested_strings_and_map_literals_preserve_interpolation_code(self):
        source = 'final label = "${{\"label\": \"${Colors.blue}\"}.toString()}";'
        self.assertEqual([f[2] for f in boundary.violations(source, True)], ['Colors.blue'])

    def test_raw_and_escaped_interpolations_are_only_text(self):
        for source in [r'final x = r"${Text(1)} ${Colors.red}";',
                       r'final x = R"${Colors.red}";',
                       r'final x = "\${Colors.red}";']:
            with self.subTest(source=source):
                self.assertEqual(boundary.violations(source, True), [])

    def test_nested_block_comments_do_not_create_false_violations(self):
        source = '/* outer /* inner */ Text("example"); Colors.red; */\nText("live");'
        self.assertEqual(boundary.violations(source, True), [(2, 'shared-control', 'Text')])

    def test_multiline_interpolation_keeps_original_diagnostic_line(self):
        source = 'final x = """text\n${\nColor(1)\n}\n""";'
        self.assertEqual(boundary.violations(source, False), [(3, 'theme-color', 'Color(')])

    def test_control_and_color_typedef_aliases_are_rejected_at_definition(self):
        source = 'typedef Label = ui.Text; typedef Tint = Color; typedef Selection<T> = ui.DropdownButton<T>;'
        self.assertEqual([f[2] for f in boundary.violations(source, True)], ['Text', 'Color', 'DropdownButton'])
        self.assertEqual([f[2] for f in boundary.violations(source, False)], ['Color'])

    def test_shared_aliases_and_inert_quoted_comment_markers_pass(self):
        source = 'typedef SharedLabel = PrimeText; final x = "/* Text( */ // Colors.red";'
        self.assertEqual(boundary.violations(source, True), [])

    def test_direct_alias_named_and_generic_controls_fail(self):
        findings = boundary.violations('ui.Text("Name"); FilledButton.tonal(onPressed: null); DropdownButton<String>();', True)
        self.assertEqual([f[2] for f in findings], ['Text', 'FilledButton', 'DropdownButton'])

    def test_comments_and_strings_do_not_create_violations(self):
        self.assertEqual(boundary.violations('// Text("x")\n/* Colors.red */\nfinal label = "Color(0xff000000)";', True), [])

    def test_shared_implementations_may_build_controls_but_not_literal_colors(self):
        self.assertEqual(boundary.violations('Text(label, style: theme.typography.bodyMedium);', False), [])
        self.assertEqual(len(boundary.violations('ui.Color(1); Color.fromARGB(1, 2, 3, 4); Colors.red.shade100;', False)), 3)

    def test_shared_controls_and_theme_tokens_pass(self):
        self.assertEqual(boundary.violations('PrimeCareCard(child: PrimeCareTextField(label: label)); final color = theme.colors.surface;', True), [])

    def test_line_numbers_survive_multiline_comments(self):
        self.assertEqual(boundary.violations('/* first\n second */\nText(label);', True)[0][0], 3)

    def test_constructor_tearoffs_cannot_bypass_shared_library(self):
        source = 'final a = ui.Text.new; final b = Text.rich; final c = FloatingActionButton.extended;'
        self.assertEqual([f[2] for f in boundary.violations(source, True)],
                         ['Text', 'Text', 'FloatingActionButton'])
        self.assertEqual(boundary.violations(source, False), [])

    def test_modern_color_constructor_and_emergency_button_fail(self):
        self.assertEqual([f[1] for f in boundary.violations(
            'final color = Color.from(alpha: 1, red: 0, green: 0, blue: 0); FloatingActionButton.large();', True)],
            ['theme-color', 'shared-control'])

    def test_foundation_allows_only_the_two_actual_underlying_implementations(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            sources = {
                'packages/primecare_ui_foundation/lib/src/prime_text.dart': 'Text(label); Icon(Icons.star); Colors.red;',
                'packages/primecare_ui_foundation/lib/src/prime_icon.dart': 'Icon(icon); Text(label); Colors.blue;',
                'packages/primecare_ui_foundation/lib/feature.dart': 'Text(label); Icon(icon);',
                'packages/flutter_core/lib/feature.dart': 'Text(label); Icon(icon);',
            }
            for relative, source in sources.items():
                path = root/relative
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(source)
            findings = boundary.scan(root)
            self.assertEqual(len(findings), 8)
            self.assertEqual([f[3] for f in findings if f[0].endswith('/prime_text.dart')], ['Icon', 'Colors.red'])
            self.assertEqual([f[3] for f in findings if f[0].endswith('/prime_icon.dart')], ['Text', 'Colors.blue'])

    def test_button_delegates_do_not_allow_other_controls_or_colors(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = root/'packages/primecare_ui_foundation/lib/src/prime_material_buttons.dart'
            path.parent.mkdir(parents=True)
            path.write_text('TextButton(child: label); ElevatedButton.icon(label: label); '
                            'OutlinedButton.styleFrom(); Scaffold(); Colors.red;')
            self.assertEqual([f[3] for f in boundary.scan(root)], ['Scaffold', 'Colors.red'])

    def test_scaffold_delegate_allows_only_scaffold_and_no_colors(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            path = root/'packages/primecare_ui_foundation/lib/src/prime_scaffold.dart'
            path.parent.mkdir(parents=True)
            path.write_text('Scaffold(body: body); AppBar(); Text(label); Colors.red;')
            self.assertEqual([f[3] for f in boundary.scan(root)],
                             ['AppBar', 'Text', 'Colors.red'])

    def test_scaffold_state_lookup_is_not_a_constructor_but_construction_still_fails(self):
        source = 'Scaffold(); Scaffold.of(context); Scaffold.new(); AppBar();'
        self.assertEqual([f[2] for f in boundary.violations(source, True)],
                         ['Scaffold', 'Scaffold', 'AppBar'])

    def test_text_field_delegate_allows_only_text_field_and_no_colors(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);path=root/'packages/primecare_ui_foundation/lib/src/prime_text_field.dart';path.parent.mkdir(parents=True)
            path.write_text('TextField(controller: controller); Text(label); AppBar(); Colors.red;')
            self.assertEqual([f[3] for f in boundary.scan(root)],['Text','AppBar','Colors.red'])

    def test_snack_bar_delegate_allows_only_snack_bar_and_no_colors(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);path=root/'packages/primecare_ui_foundation/lib/src/prime_snack_bar.dart';path.parent.mkdir(parents=True)
            path.write_text('SnackBar(content: content); Card(); Text(label); Colors.red;')
            self.assertEqual([f[3] for f in boundary.scan(root)],['Card','Text','Colors.red'])

    def test_card_delegate_allows_only_card_and_no_colors(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);path=root/'packages/primecare_ui_foundation/lib/src/prime_card.dart';path.parent.mkdir(parents=True)
            path.write_text('Card(child: child); SnackBar(content: child); Text(label); Colors.red;')
            self.assertEqual([f[3] for f in boundary.scan(root)],['SnackBar','Text','Colors.red'])

    def test_app_bar_delegate_allows_only_app_bar_and_no_colors(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);path=root/'packages/primecare_ui_foundation/lib/src/prime_app_bar.dart';path.parent.mkdir(parents=True)
            path.write_text('AppBar(title: title); Card(); Text(label); Colors.red;')
            self.assertEqual([f[3] for f in boundary.scan(root)],['Card','Text','Colors.red'])

    def test_extended_primitive_implementations_are_exact_and_color_strict(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory)
            for filename, source in [('prime_icon_button.dart', 'IconButton(icon: icon); Text(label); Colors.red;'),
                                     ('prime_rich_text.dart', 'RichText(text: span); Icon(icon); Colors.blue;')]:
                path=root/'packages/primecare_ui_foundation/lib/src'/filename
                path.parent.mkdir(parents=True,exist_ok=True);path.write_text(source)
            self.assertEqual([f[3] for f in boundary.scan(root)], ['Text', 'Colors.red', 'Icon', 'Colors.blue'])

    def test_real_pdf_namespace_is_distinct_from_material_and_shadowed_names(self):
        prefix = "import 'package:pdf/widgets.dart' as pw;\n"
        source = prefix+'pw.Text("Report"); typedef PdfText = pw.Text; Icon(Icons.menu); Colors.red;'
        self.assertEqual([f[2] for f in boundary.violations(source,True)], ['Icon','Colors.red'])
        for source in ["import 'package:flutter/material.dart' as pw; pw.Text('UI');",
                       '// '+prefix+"pw.Text('UI');",
                       prefix+"final pw = service; pw.Text('UI');",
                       prefix+"Widget f(Object pw) => pw.Text('UI');",
                       prefix+"material.Text('UI');",
                       prefix+"part 'shadow.dart'; pw.Text('UI');"]:
            self.assertIn('Text',[f[2] for f in boundary.violations(source,True)])

    def test_progress_renderer_allows_no_other_controls_or_literal_colors(self):
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory)
            path=root/'packages/primecare_ui_foundation/lib/src/prime_circular_progress_indicator.dart'
            path.parent.mkdir(parents=True)
            path.write_text('CircularProgressIndicator(value: value); Card(); Colors.red;')
            self.assertEqual([f[3] for f in boundary.scan(root)], ['Card','Colors.red'])

    def test_material_inheritance_cannot_bypass_shared_library(self):
        for source in ['class Direct extends Slider {}','class Direct extends material.ListTile {}','class Direct implements DropdownButton<String> {}']:
            self.assertIn('shared-control',[row[1] for row in boundary.violations(source,True)])
        with tempfile.TemporaryDirectory() as directory:
            root=Path(directory);path=root/'packages/primecare_ui_foundation/lib/src/prime_material_controls.dart';path.parent.mkdir(parents=True)
            path.write_text('class PrimeSlider extends Slider {} AppBar(); Colors.red;')
            self.assertEqual([row[3] for row in boundary.scan(root)],['AppBar','Colors.red'])

    def test_scan_keeps_existing_violations_and_shared_library_boundary(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            sources = {
                'apps/demo/lib/view.dart': 'Text("direct");',
                'apps/demo/test/view_test.dart': 'Text("test fixture");',
                'packages/primecare_ui/lib/src/components/card.dart': 'Text("shared"); Colors.white;',
                'packages/primecare_ui/lib/src/theme/palette.dart': 'Color(1);',
                'packages/feature/lib/view.dart': 'Text("bypass"); Colors.red;',
                'packages/feature/test/view_test.dart': 'Text("fixture");',
            }
            for relative, source in sources.items():
                path = root / relative
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(source, encoding='utf-8')
            self.assertEqual([(f[0], f[2]) for f in boundary.scan(root)], [
                ('apps/demo/lib/view.dart', 'shared-control'),
                ('packages/feature/lib/view.dart', 'shared-control'),
                ('packages/feature/lib/view.dart', 'theme-color'),
                ('packages/primecare_ui/lib/src/components/card.dart', 'theme-color'),
            ])
