import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_theme/workspace/portal_workspace.dart';

void main() {
  testWidgets('portal workspace supplies the existing presentation controller', (tester) async {
    await tester.pumpWidget(MaterialApp(home: PortalWorkspace(
      scope: WorkspaceScope(tenant: 'fixture', user: 'fixture', role: 'staff'),
      legacyLayoutStyle: 'verticalLeft',
      builder: (context, controller) => const Text('Authorized fixture slot'),
    )));
    expect(find.text('Authorized fixture slot'), findsOneWidget);
  });
}
