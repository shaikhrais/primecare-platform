import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart';

void main() {
  testWidgets('progress values, geometry and SDK defaults remain identical', (tester) async {
    for(final brightness in Brightness.values) {
      for(final value in <double?>[null,0,.5,1]) {
        final theme=ThemeData(brightness:brightness,
          progressIndicatorTheme:const ProgressIndicatorThemeData(color:Colors.purple));
        await tester.pumpWidget(MaterialApp(theme:theme,home:Scaffold(body:Column(children:[
          CircularProgressIndicator(key:const Key('original'),value:value),
          PrimeCircularProgressIndicator(key:const Key('shared'),value:value),
        ]))));
        await tester.pump();
        final delegate=tester.widget<CircularProgressIndicator>(find.descendant(
          of:find.byKey(const Key('shared')),matching:find.byType(CircularProgressIndicator)));
        expect(delegate.value,value);expect(delegate.strokeWidth,isNull);
        expect(delegate.color,isNull);expect(delegate.valueColor,isNull);
        expect(tester.getSize(find.byKey(const Key('shared'))),tester.getSize(find.byKey(const Key('original'))));
        expect(tester.takeException(),isNull);
      }
    }
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('explicit animations, stroke cap, color and semantics reach the SDK renderer', (tester) async {
    const animation=AlwaysStoppedAnimation<Color>(Colors.green);
    await tester.pumpWidget(const MaterialApp(home:Scaffold(body:PrimeCircularProgressIndicator(
      value:.42,valueColor:animation,backgroundColor:Colors.grey,strokeWidth:12,
      strokeCap:StrokeCap.round,semanticsLabel:'Readiness',semanticsValue:'42 percent',
    ))));
    final delegate=tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));
    expect(delegate.value,.42);expect(delegate.valueColor,same(animation));
    expect(delegate.backgroundColor,Colors.grey);expect(delegate.strokeWidth,12);
    expect(delegate.strokeCap,StrokeCap.round);expect(delegate.semanticsLabel,'Readiness');
    expect(delegate.semanticsValue,'42 percent');expect(tester.takeException(),isNull);
    await tester.pumpWidget(const MaterialApp(home:Scaffold(body:PrimeCircularProgressIndicator(color:Colors.orange))));
    expect(tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator)).color,Colors.orange);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
