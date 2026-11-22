import 'package:flutter_core/original_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_kitchen_sink/primecare_kitchen_sink.dart';

void main() {
  testWidgets('all native previews fit a narrow viewport without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        theme: kitchenSinkTheme(),
        home: const PrimeKitchenSinkGallery(),
      ),
    );
    await tester.pump();
    expect(find.text('36 / 36'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'catalogue mounts real shared controls and preserves a draft across filtering',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: kitchenSinkTheme(),
          home: const PrimeKitchenSinkGallery(),
        ),
      );
      await tester.pump();
      expect(find.text('36 / 36'), findsOneWidget);
      expect(find.byType(PrimeCatalogueAction), findsWidgets);
      final field = find
          .byWidgetPredicate(
            (widget) => widget is TextFormField && widget.controller != null,
          )
          .first;
      final controller = tester.widget<TextFormField>(field).controller!;
      controller.text = 'Retained draft';
      await tester.enterText(
        find.byKey(const ValueKey('kitchen-sink-search')),
        'PrimeComponentFactory.field',
      );
      await tester.pump();
      expect(find.text('2 / 36'), findsOneWidget);
      expect(controller.text, 'Retained draft');
      await tester.enterText(
        find.byKey(const ValueKey('kitchen-sink-search')),
        '',
      );
      await tester.pump();
      expect(find.text('36 / 36'), findsOneWidget);
      expect(controller.text, 'Retained draft');
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'locale and dark theme keep the same canonical gallery and dispose timers',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: kitchenSinkTheme(),
          home: const PrimeKitchenSinkGallery(),
        ),
      );
      await tester.pump();
      await tester.pumpWidget(
        MaterialApp(
          theme: kitchenSinkTheme(dark: true),
          home: const PrimeKitchenSinkGallery(locale: 'fr'),
        ),
      );
      await tester.pump();
      expect(find.text('Catalogue des composants'), findsOneWidget);
      expect(find.text('36 / 36'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 65));
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'all canonical assets render at phone width through the shared renderer',
    (tester) async {
      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(
        MaterialApp(
          theme: kitchenSinkTheme(dark: true),
          home: const PrimeKitchenSinkGallery(locale: 'es'),
        ),
      );
      await tester.enterText(
        find.byKey(const ValueKey('kitchen-sink-search')),
        'no-matching-preview',
      );
      await tester.pump();
      await tester.ensureVisible(find.byKey(const Key('ks-assets')));
      await tester.tap(find.byKey(const Key('ks-assets')));
      await tester.pumpAndSettle();
      expect(
        find.byType(PrimeOriginalAsset),
        findsNWidgets(originalAssetNames.length),
      );
      for (final name in originalAssetNames) {
        expect(find.byKey(Key('ks-asset-$name')), findsOneWidget);
      }
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );
}
