import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_responsive_screen/primecare_responsive_screen.dart';
void main() { testWidgets('wrapper retains content', (tester) async { await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: ResponsiveScreenWrapper(child: Text('Fixture'))))); expect(find.text('Fixture'), findsOneWidget); expect(tester.takeException(), isNull); }); }
