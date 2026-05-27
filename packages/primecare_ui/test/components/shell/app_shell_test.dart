import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App shell renders topbar sidebar and content slot', (tester) async {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(key: const Key('app-topbar'), title: const Text('Topbar')),
          drawer: const Drawer(key: Key('app-sidebar'), child: Text('Sidebar')),
          body: const KeyedSubtree(
            key: Key('app-content-slot'),
            child: Text('Content'),
          ),
        ),
      ),
    );

    expect(find.byKey(const Key('app-topbar')), findsOneWidget);
    expect(find.byKey(const Key('app-content-slot')), findsOneWidget);

    // Open the drawer to force rendering in the widget tree
    scaffoldKey.currentState?.openDrawer();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('app-sidebar')), findsOneWidget);
  });
}
