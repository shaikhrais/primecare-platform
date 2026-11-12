import 'dart:convert';
import 'dart:io';
import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/component_catalogue.dart';

void main() {
  final labels = CatalogueLabels.fromMetadata(
    jsonDecode(File('../primecare_ui/catalogs/component-catalogue.registration.json').readAsStringSync()),
    'en',
  );

  for (final departure in ['pointer', 'focus']) {
    testWidgets('Escape dismissal survives $departure departure until a new interaction', (tester) async {
      await tester.pumpWidget(MaterialApp(home: Scaffold(body: Align(
        alignment: Alignment.topLeft,
        child: PrimeComponentKit(labels, 'tooltip-dismissal').tooltip('Dismissible native help'),
      ))));
      final trigger = find.descendant(
        of: find.byWidgetPredicate((widget) => widget is Semantics && widget.properties.identifier == 'component-catalogue-tooltip-trigger'),
        matching: find.byType(Text),
      );
      Focus.of(tester.element(trigger)).requestFocus();
      await tester.pumpAndSettle();
      final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await mouse.addPointer(location: const Offset(790, 590));
      await mouse.moveTo(tester.getCenter(trigger));
      await tester.pumpAndSettle();
      expect(find.text('Dismissible native help'), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pumpAndSettle();
      expect(find.text('Dismissible native help'), findsNothing);

      if (departure == 'pointer') {
        await mouse.moveTo(const Offset(790, 590));
      } else {
        FocusManager.instance.primaryFocus?.unfocus();
      }
      await tester.pumpAndSettle();
      expect(find.text('Dismissible native help'), findsNothing);

      // A new pointer entry, rather than the departure itself, may show help again.
      await mouse.moveTo(const Offset(790, 590));
      await tester.pumpAndSettle();
      await mouse.moveTo(tester.getCenter(trigger));
      await tester.pumpAndSettle();
      expect(find.text('Dismissible native help'), findsOneWidget);
      await mouse.removePointer();
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tester.takeException(), isNull);
    });
  }
}
