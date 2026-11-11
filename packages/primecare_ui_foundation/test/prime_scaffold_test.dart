import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

void main() {
  testWidgets('PrimeScaffold delegates reviewed fields and inherited defaults',
      (tester) async {
    const body = SizedBox(key: Key('body'));
    final appBar = AppBar(title: const Text('Title'));
    const fab = FloatingActionButton(onPressed: null);
    const drawer = Drawer(key: Key('drawer'));
    const endDrawer = Drawer(key: Key('end-drawer'));

    await tester.pumpWidget(MaterialApp(
      home: PrimeScaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: fab,
        drawer: drawer,
        endDrawer: endDrawer,
        backgroundColor: Color(0xff123456),
      ),
    ));

    final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
    expect(scaffold.appBar, same(appBar));
    expect(scaffold.body, same(body));
    expect(scaffold.floatingActionButton, same(fab));
    expect(scaffold.drawer, same(drawer));
    expect(scaffold.endDrawer, same(endDrawer));
    expect(scaffold.backgroundColor, const Color(0xff123456));
    expect(scaffold.primary, isTrue);
    expect(scaffold.extendBody, isFalse);
    expect(scaffold.extendBodyBehindAppBar, isFalse);
    expect(scaffold.resizeToAvoidBottomInset, isNull);
  });

  testWidgets('Scaffold.of state lookup still opens both delegated drawers',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PrimeScaffold(
        drawer: const Drawer(child: Text('Start drawer')),
        endDrawer: const Drawer(child: Text('End drawer')),
        body: Builder(builder: (context) {
          return Row(children: [
            TextButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: const Text('Open start'),
            ),
            TextButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              child: const Text('Open end'),
            ),
          ]);
        }),
      ),
    ));

    await tester.tap(find.text('Open start'));
    await tester.pumpAndSettle();
    expect(find.text('Start drawer'), findsOneWidget);
    Navigator.of(tester.element(find.text('Start drawer'))).pop();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Open end'));
    await tester.pumpAndSettle();
    expect(find.text('End drawer'), findsOneWidget);
  });
}
