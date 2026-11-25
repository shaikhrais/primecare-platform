import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_screen_models/primecare_screen_models.dart';

void main() {
  test('screen metadata and navigation retain typed icons', () {
    const screen = ScreenMetadata(id: 'fixture', title: 'Fixture', icon: Icons.home);
    expect(screen.icon, Icons.home);
    expect(screen.copyWith(title: 'Updated').title, 'Updated');
    const item = PrimeCareNavigationItem(label: 'Fixture', icon: Icons.home, route: '/fixture');
    expect(item.route, '/fixture');
  });
  testWidgets('screen defaults preserve child', (tester) async {
    await tester.pumpWidget(MaterialApp(home: const ScreenFeatureConfig().wrap(const Text('Fixture'))));
    expect(find.text('Fixture'), findsOneWidget);
  });
}
