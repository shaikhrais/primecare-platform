import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/original_assets.dart';

void main() {
  Future<int> maximumAlpha(
    WidgetTester tester, {
    required double opacity,
    Color? explicitColor,
  }) async {
    final key = GlobalKey();
    await tester.pumpWidget(MaterialApp(
      home: Center(
        child: RepaintBoundary(
          key: key,
          child: IconTheme(
            data: IconThemeData(
              color: const Color(0xffc02030),
              opacity: opacity,
            ),
            child: PrimeOriginalAsset(
              'arrow-right',
              size: 48,
              color: explicitColor,
            ),
          ),
        ),
      ),
    ));
    await tester.pump();
    final boundary = tester.renderObject<RenderRepaintBoundary>(find.byKey(key));
    return (await tester.runAsync<int>(() async {
      final image = await boundary.toImage(pixelRatio: 1);
      try {
        final bytes = (await image.toByteData(format: ui.ImageByteFormat.rawRgba))!;
        final pixels = bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
        var maximum = 0;
        for (var index = 3; index < pixels.length; index += 4) {
          if (pixels[index] > maximum) maximum = pixels[index];
        }
        return maximum;
      } finally {
        image.dispose();
      }
    }))!;
  }

  testWidgets('inherited foreground respects icon theme opacity', (tester) async {
    expect(await maximumAlpha(tester, opacity: 1), 255);
    expect(await maximumAlpha(tester, opacity: .25), inInclusiveRange(63, 64));
    expect(tester.takeException(), isNull);
  });

  testWidgets('explicit foreground alpha multiplies icon theme opacity', (tester) async {
    const explicit = Color.from(alpha: .5, red: 1, green: 0, blue: 0);
    expect(await maximumAlpha(tester, opacity: 1, explicitColor: explicit), inInclusiveRange(127, 128));
    expect(await maximumAlpha(tester, opacity: .25, explicitColor: explicit), inInclusiveRange(31, 32));
    expect(tester.takeException(), isNull);
  });

  testWidgets('zero icon theme opacity hides inherited and explicit foregrounds', (tester) async {
    expect(await maximumAlpha(tester, opacity: 0), 0);
    expect(await maximumAlpha(tester, opacity: 0, explicitColor: Colors.red), 0);
    expect(tester.takeException(), isNull);
  });
}
