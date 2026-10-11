"""Build the actual shared report UI/plugins in a disposable native runner.

This isolates reporting from unrelated unfinished application features. It is
a compilation check, not device testing or a distributable production app.
"""
import argparse
import importlib.util
from pathlib import Path
import shutil
import subprocess
import tempfile

parser = argparse.ArgumentParser()
parser.add_argument('platform', choices=['web', 'android', 'ios', 'windows', 'macos', 'linux'])
args = parser.parse_args()
root = Path(__file__).resolve().parents[1]
flutter = shutil.which('flutter')
if not flutter:
    raise SystemExit('Flutter is required')
app = Path(tempfile.mkdtemp(prefix='primecare_report_smoke_'))


def run(*command):
    subprocess.run([flutter, *command], cwd=app, check=True)


run('create', '--no-pub', '--project-name=report_smoke', f'--platforms={args.platform}', '.')
(app / 'pubspec.yaml').write_text(f'''name: report_smoke
publish_to: none
environment:
  sdk: ^3.11.3
dependencies:
  flutter:
    sdk: flutter
  primecare_ui:
    path: "{(root / 'packages/primecare_ui').as_posix()}"
flutter:
  uses-material-design: true
''')
(app / 'lib/main.dart').write_text('''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/src/theme/prime_theme.dart';
import 'package:primecare_ui/src/features/reports/admin_reports_panel.dart';
void main() => runApp(ProviderScope(child: MaterialApp(home: PrimeTheme(
  data: const PrimeThemeData(), child: const Scaffold(body: SingleChildScrollView(
    child: AdminReportsPanel(endpoint: '/v1/governance/reports')))))));
''')
if args.platform == 'macos':
    spec = importlib.util.spec_from_file_location('macos', root / 'scripts/configure-report-macos.py')
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    module.configure(app)
run('pub', 'get')
build_args = {'android': ['apk', '--debug'], 'ios': ['ios', '--release', '--no-codesign']}
run('build', *build_args.get(args.platform, [args.platform, '--release']))
print(f'Report {args.platform} compilation passed: {app}')
