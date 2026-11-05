import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/models/screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DefaultScreen extends GovernedStatelessWidget {
  const DefaultScreen({super.key});
  @override Widget buildScreen(BuildContext context) => const SizedBox(key: Key('screen'), width: 100, height: 20);
}
class OverrideScreen extends GovernedConsumerWidget {
  const OverrideScreen({super.key});
  @override ScreenFeatureConfig get screenFeatures => const ScreenFeatureConfig(padding: EdgeInsets.all(13));
  @override Widget buildScreen(BuildContext context, WidgetRef ref) => const SizedBox(key: Key('screen'), width: 100, height: 20);
}
void main() {
  Widget app(Widget screen, ScreenFeatureConfig features) => ProviderScope(child: MaterialApp(home: ScreenFeatureScope(features: features, child: AppShellBoundary(child: screen))));
  testWidgets('governed screens inherit app settings and respond to changes', (tester) async {
    await tester.pumpWidget(app(const DefaultScreen(), const ScreenFeatureConfig(padding: EdgeInsets.all(7))));
    expect(find.ancestor(of: find.byKey(const Key('screen')), matching: find.byWidgetPredicate((w) => w is Padding && w.padding == const EdgeInsets.all(7))), findsOneWidget);
    await tester.pumpWidget(app(const DefaultScreen(), const ScreenFeatureConfig(padding: EdgeInsets.all(11))));
    expect(find.ancestor(of: find.byKey(const Key('screen')), matching: find.byWidgetPredicate((w) => w is Padding && w.padding == const EdgeInsets.all(11))), findsOneWidget);
  });
  testWidgets('screen settings override app settings without weakening shell boundary', (tester) async {
    await tester.pumpWidget(app(const OverrideScreen(), const ScreenFeatureConfig(padding: EdgeInsets.all(7))));
    expect(find.ancestor(of: find.byKey(const Key('screen')), matching: find.byWidgetPredicate((w) => w is Padding && w.padding == const EdgeInsets.all(13))), findsOneWidget);
    await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: OverrideScreen())));
    expect(tester.takeException(), isA<FlutterError>());
  });
  testWidgets('default wrapping does not introduce presentation widgets', (tester) async {
    const child = SizedBox();
    expect(const ScreenFeatureConfig().wrap(child), same(child));
  });
}
