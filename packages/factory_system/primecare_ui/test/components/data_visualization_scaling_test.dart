import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_ui/primecare_ui.dart';


import 'package:google_fonts/google_fonts.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Widget buildTestableWidget({
    required Widget child,
    required ResolutionTier tier,
    required double scaleFactor,
    bool isDarkMode = false,
  }) {
    return ProviderScope(
      overrides: [
        layoutProvider.overrideWithValue(
          LayoutConfig(
            tier: tier,
            scaleFactor: scaleFactor,
            sidebarWidth: 280 * scaleFactor,
            spacingMultiplier: scaleFactor,
          ),
        ),
      ],
      child: MaterialApp(
        theme: isDarkMode
            ? PrimeCareDesignSystem.darkTheme
            : PrimeCareDesignSystem.lightTheme,
        home: Scaffold(body: child),
      ),
    );
  }

  group('Data Visualization Component Scaling Regression Tests', () {
    testWidgets('PrimeStatusBadge scales padding and font size', (
      tester,
    ) async {
      const scale = 3.0; // Mega Display
      await tester.pumpWidget(
        buildTestableWidget(
          tier: ResolutionTier.mega,
          scaleFactor: scale,
          child: const PrimeStatusBadge(
            label: 'COMPLETED',
            type: BadgeType.success,
          ),
        ),
      );

      // Verify Label Scaling
      final labelFinder = find.text('COMPLETED');
      expect(labelFinder, findsOneWidget);
      final labelText = tester.widget<Text>(labelFinder);
      expect(labelText.style?.fontSize, equals(11.0 * scale));

      // Verify Container Padding (horizontal = 8, vertical = 4)
      final containerFinder = find.byType(Container).first;
      final container = tester.widget<Container>(containerFinder);
      final padding = container.padding as EdgeInsets;
      expect(padding.left, equals(8.0 * scale));
      expect(padding.top, equals(4.0 * scale));

      // Verify Color Mapping (Success)
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(const Color(0xFFF0FDF4)));
    });

    testWidgets('PrimeCareDataTable scales row heights and header typography', (
      tester,
    ) async {
      const scale = 2.0; // 4K Display
      await tester.pumpWidget(
        buildTestableWidget(
          tier: ResolutionTier.fourK,
          scaleFactor: scale,
          child: PrimeCareDataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Patient')),
            ],
            rows: [
              DataRow(
                cells: [
                  const DataCell(Text('101')),
                  const DataCell(Text('John Doe')),
                ],
              ),
            ],
          ),
        ),
      );

      final tableFinder = find.byType(DataTable);
      expect(tableFinder, findsOneWidget);
      final table = tester.widget<DataTable>(tableFinder);

      // Verify Row Height Scaling (default 56 -> 56 * scale)
      expect(table.dataRowMinHeight, equals(56.0 * scale));

      // Verify Header Typography Scaling (Effective Style via RenderObject)
      final headerFinder = find.text('ID');
      final renderParagraph = tester.renderObject<RenderParagraph>(
        headerFinder,
      );
      expect(renderParagraph.text.style?.fontSize, equals(12.0 * scale));
      expect(renderParagraph.text.style?.fontWeight, equals(FontWeight.w700));
    });

    testWidgets('PrimeCareButton scales dimensions and border radius', (
      tester,
    ) async {
      const scale = 2.0; // 4K Display
      await tester.pumpWidget(
        buildTestableWidget(
          tier: ResolutionTier.fourK,
          scaleFactor: scale,
          child: PrimeCareButton(
            label: 'SAVE REPORT',
            onPressed: () {},
            type: PrimeCareButtonType.primary,
          ),
        ),
      );

      // Search for our custom AnimatedContainer inside PrimeCareButton
      final containerFinder = find.byType(AnimatedContainer);
      expect(containerFinder, findsOneWidget);
      final container = tester.widget<AnimatedContainer>(containerFinder);

      // Verify Border Radius (8 * scale - using PrimeCareRadii.scaled)
      final decoration = container.decoration as BoxDecoration;
      expect(
        decoration.borderRadius,
        equals(BorderRadius.circular(8.0 * scale)),
      );

      // Verify Padding Scaling (h: 24, v: 14 as implemented)
      final padding = container.padding as EdgeInsets;
      expect(padding.horizontal, equals(24.0 * scale * 2));
      expect(padding.vertical, equals(14.0 * scale * 2));
    });
  });
}
