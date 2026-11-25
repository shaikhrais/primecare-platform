import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_layout/primecare_layout.dart';
void main() {
  test('breakpoint boundaries and grid sizing are preserved', () {
    expect([767,768,1024,1440,2560,3840,5120].map((w)=>ScreenBreakpoints.getTier(w.toDouble())), ResolutionTier.values);
    expect(ScreenBreakpoints.getTier(3840, pixelRatio: 4), ResolutionTier.mega);
    expect(ResolutionTier.values.map(AdaptiveScalingConfig.getGridColumns), [4,8,12,16,20,20,24]);
    expect(AdaptiveScalingConfig.getSidebarSpan(ResolutionTier.mob), 0);
    expect(AdaptiveScalingConfig.getScaleFactor(ResolutionTier.mega), 3.0);
  });
  testWidgets('grid naturally wraps and caps card width at desktop and mobile sizes', (tester) async {
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    const first = ValueKey('first');
    const second = ValueKey('second');
    const third = ValueKey('third');
    Widget fixture() => const MaterialApp(home: Center(child: ResponsiveGrid(
      children: [
        SizedBox(key: first, height: 40),
        SizedBox(key: second, height: 40),
        SizedBox(key: third, height: 40),
      ],
    )));
    tester.view.physicalSize = const Size(1200, 800);
    await tester.pumpWidget(fixture());
    expect(tester.getSize(find.byKey(first)).width, 288);
    expect(tester.getTopLeft(find.byKey(first)).dy, tester.getTopLeft(find.byKey(second)).dy);
    tester.view.physicalSize = const Size(360, 800);
    await tester.pumpWidget(fixture());
    await tester.pumpAndSettle();
    expect(tester.getSize(find.byKey(first)).width, 360);
    expect(tester.getTopLeft(find.byKey(second)).dy, greaterThan(tester.getTopLeft(find.byKey(first)).dy));
    expect(tester.takeException(), isNull);
  });
}
