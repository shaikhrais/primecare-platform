import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_runtime/workspace.dart';

class MemoryPreferences implements WorkspacePreferences {
  final values = <String, String>{};
  @override Future<String?> read(String key) async => values[key];
  @override Future<void> write(String key, String value) async { values[key] = value; }
}
void main() {
  testWidgets('portal saves restores and isolates actor layouts', (tester) async {
    final preferences = MemoryPreferences();
    late WorkspaceController current;
    Future<void> mount(String user) async {
      await tester.pumpWidget(MaterialApp(home: PortalWorkspace(
        scope: WorkspaceScope(tenant: 'tenant', user: user, role: 'staff'),
        preferences: preferences, legacyLayoutStyle: 'verticalLeft',
        builder: (context, c) { current = c; return const Scaffold(body: SingleChildScrollView(child: PortalLayoutEditor())); })));
      await tester.pumpAndSettle();
    }
    await mount('a');
    current.patch({'navigation': 'right', 'toolbar': 'bottom', 'footer': 'sticky'});
    await current.save();
    await mount('b');
    expect(current.current.navigation, 'left');
    current.patch({'navigation': 'hidden'});
    await current.save();
    await mount('a');
    expect(current.current.navigation, 'right');
    expect(current.current.toolbar, 'bottom');
    expect(current.current.footer, 'sticky');
    expect(tester.takeException(), isNull);
  });
  testWidgets('JSON import rejects authority fields and applies a valid layout', (tester) async {
    late WorkspaceController current;
    await tester.pumpWidget(MaterialApp(home: PortalWorkspace(
      scope: WorkspaceScope(tenant: 'tenant', user: 'a', role: 'staff'),
      legacyLayoutStyle: 'verticalLeft',
      builder: (context, c) { current = c; return const Scaffold(
        body: SingleChildScrollView(child: PortalLayoutEditor())); })));
    await tester.pumpAndSettle();
    final valid = current.current.patch({'navigation': 'right'}).exportJson();
    await tester.ensureVisible(find.text('Import JSON'));
    await tester.tap(find.text('Import JSON'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '{"role":"admin"}');
    await tester.tap(find.text('Apply'));
    await tester.pumpAndSettle();
    expect(find.text('Invalid or incompatible layout JSON.'), findsOneWidget);
    expect(current.current.navigation, 'left');
    await tester.enterText(find.byType(TextField), valid);
    await tester.tap(find.text('Apply'));
    await tester.pumpAndSettle();
    expect(current.current.navigation, 'right');
    expect(tester.takeException(), isNull);
  });
  testWidgets('footer and editor share one controller; hidden footer is recoverable', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    late WorkspaceController current;
    await tester.pumpWidget(MaterialApp(home: PortalWorkspace(
      scope: WorkspaceScope(tenant: 'tenant', user: 'a', role: 'staff'),
      legacyLayoutStyle: 'collapsed',
      builder: (context, c) { current = c; return Scaffold(
        endDrawer: const Drawer(child: SingleChildScrollView(child: PortalLayoutEditor())),
        body: PrimeWorkspaceLayout(controller: c, navigationVisible: false,
          navigation: const Text('Allowed routes'),
          toolbar: Builder(builder: (context) => IconButton(icon: const Icon(Icons.settings),
            tooltip: 'Open layout', onPressed: () => Scaffold.of(context).openEndDrawer())),
          footer: const PortalLayoutFooter(), main: const TextField(key: Key('draft')), panels: const {})); })));
    await tester.pumpAndSettle();
    expect(current.current.navigationWidth, 64);
    await tester.enterText(find.byKey(const Key('draft')), 'Keep unfinished form');
    current.patch({'toolbar': 'bottom', 'footer': 'hidden'});
    await tester.pumpAndSettle();
    expect(find.text('Layout · temporary'), findsNothing);
    expect(find.text('Keep unfinished form'), findsOneWidget);
    await tester.tap(find.byTooltip('Open layout'));
    await tester.pumpAndSettle();
    expect(find.text('WORKSPACE LAYOUT'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
