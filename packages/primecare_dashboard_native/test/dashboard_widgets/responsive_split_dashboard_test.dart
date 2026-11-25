import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_dashboard_native/primecare_dashboard_native.dart';

void main() {
  testWidgets('wide dashboards split and mobile dashboards stack', (tester) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    const main = ValueKey('main');
    const side = ValueKey('side');
    Widget fixture() => const MaterialApp(
      home: ResponsiveSplitDashboard(
        metrics: [],
        mainContent: SizedBox(key: main, height: 80, width: 100),
        sidebarContent: SizedBox(key: side, height: 80, width: 100),
      ),
    );
    tester.view.physicalSize = const Size(1200, 800);
    await tester.pumpWidget(fixture());
    expect(tester.getTopLeft(find.byKey(side)).dx, greaterThan(tester.getTopLeft(find.byKey(main)).dx));
    expect(tester.getTopLeft(find.byKey(side)).dy, tester.getTopLeft(find.byKey(main)).dy);
    tester.view.physicalSize = const Size(360, 800);
    await tester.pumpWidget(fixture());
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(find.byKey(side)).dx, tester.getTopLeft(find.byKey(main)).dx);
    expect(tester.getTopLeft(find.byKey(side)).dy, greaterThan(tester.getTopLeft(find.byKey(main)).dy));
    expect(tester.takeException(), isNull);
  });
}
