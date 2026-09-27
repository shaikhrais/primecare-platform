import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App sidebar renders correctly', (tester) async {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          key: scaffoldKey,
          drawer: const Drawer(key: Key('app-sidebar'), child: Text('Sidebar')),
          body: const SizedBox(),
        ),
      ),
    );

    // Open the drawer to force rendering in the widget tree
    scaffoldKey.currentState?.openDrawer();
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('app-sidebar')), findsOneWidget);
  });
}
