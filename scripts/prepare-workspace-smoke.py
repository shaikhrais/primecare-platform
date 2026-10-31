"""Prepare a disposable build harness; never a route, app registration or live demo."""
import json
from pathlib import Path
import sys
root = Path(__file__).resolve().parents[1]
target = Path(sys.argv[1]).resolve()
if not target.is_dir() or target == root or root in target.parents:
    raise SystemExit('Use an existing disposable directory outside the repository')
(target / 'pubspec.yaml').write_text('''name: workspace_smoke
publish_to: none
environment:
  sdk: ^3.11.3
dependencies:
  flutter:
    sdk: flutter
  flutter_core:
    path: ''' + json.dumps(str(root / 'packages/flutter_core')) + '''
flutter:
  uses-material-design: true
''')
(target / 'lib/main.dart').write_text('''import 'package:flutter/material.dart';
import 'package:flutter_core/workspace.dart';
void main() => runApp(const Harness());
class Harness extends StatefulWidget {
  const Harness({super.key});
  @override State<Harness> createState() => HarnessState();
}
class HarnessState extends State<Harness> {
  late final controller = WorkspaceController(scope: WorkspaceScope(tenant:'fixture', user:'fixture', role:'fixture'), panelIds:['note']);
  @override void dispose() {controller.dispose();super.dispose();}
  @override Widget build(BuildContext context) => MaterialApp(home: Scaffold(body: PrimeWorkspaceLayout(
    controller:controller, navigation:const Text('Fixture navigation'), toolbar:const Text('Fixture toolbar'),
    main:const TextField(), panels:const {'note':TextField()},
    handleLabels:const {'note':WorkspaceHandleLabels(move:'Move fixture',resize:'Resize fixture',instructions:'Arrow keys')},
  )));
}
''')
