import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App topbar renders correctly', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: KeyedSubtree(key: Key('app-topbar'), child: Text('Topbar')),
          ),
        ),
      ),
    );
    expect(find.byKey(const Key('app-topbar')), findsOneWidget);
  });
}