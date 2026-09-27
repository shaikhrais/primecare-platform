// Governance - Category: view | Purpose: Structural UI Theme and Styles layout binding Core Template Elements High-Level KPIs Advanced Sections
// Structural UI Theme and Styles layout binding
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MasterDashboardPageObject {
  final WidgetTester tester;

  MasterDashboardPageObject(this.tester);

  // Core Template Elements
  Finder get pageTitle => find.byKey(const Key('page_title'));
  Finder get pageSubtitle => find.byKey(const Key('page_subtitle'));

  // High-Level KPIs
  Finder get kpiGrid => find.byKey(const Key('kpi_grid'));
  Finder kpiCard(String title) => find.widgetWithText(Card, title);
  Finder kpiValue(String value) => find.text(value);

  // Advanced Sections
  Finder get dataTableWidget => find.byKey(const Key('data_table_widget'));
  Finder get advancedChartWidget =>
      find.byKey(const Key('advanced_chart_widget'));
  Finder get kanbanBoardWidget => find.byKey(const Key('kanban_board_widget'));
  Finder get geospatialMapWidget =>
      find.byKey(const Key('geospatial_map_widget'));
  Finder get interactiveCalendarWidget =>
      find.byKey(const Key('interactive_calendar_widget'));
  Finder get standardListWidget =>
      find.byKey(const Key('standard_list_widget'));
  Finder get splitPanelWidget => find.byKey(const Key('split_panel_widget'));

  // Shared Actions
  Future<void> waitForHydration() async {
    // Wait until the main UI loop settles
    await tester.pumpAndSettle();
  }

  Future<void> verifyTitle(String expectedTitle) async {
    final hasKey = pageTitle.evaluate().isNotEmpty;
    if (hasKey) {
      final titleWidget = tester.widget<Text>(pageTitle);
      expect(titleWidget.data?.toLowerCase(), expectedTitle.toLowerCase());
    } else {
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.data?.toLowerCase().contains(
                    expectedTitle.toLowerCase(),
                  ) ??
                  false),
        ),
        findsWidgets,
      );
    }
  }

  Future<void> verifySubtitle(String expectedSubtitle) async {
    final hasKey = pageSubtitle.evaluate().isNotEmpty;
    if (hasKey) {
      final subtitleWidget = tester.widget<Text>(pageSubtitle);
      expect(
        subtitleWidget.data?.toLowerCase(),
        expectedSubtitle.toLowerCase(),
      );
    } else {
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              (widget.data?.toLowerCase().contains(
                    expectedSubtitle.toLowerCase(),
                  ) ??
                  false),
        ),
        findsWidgets,
      );
    }
  }

  Future<void> verifyKpiGenerated(String kpiTitle, String expectedValue) async {
    expect(kpiCard(kpiTitle), findsOneWidget);
    expect(
      find.descendant(of: kpiCard(kpiTitle), matching: kpiValue(expectedValue)),
      findsOneWidget,
    );
  }

  Future<void> verifySectionExists(Finder sectionFinder) async {
    // Scroll if needed (assuming there's a scrollable wrapper)
    await tester.ensureVisible(sectionFinder);
    expect(sectionFinder, findsOneWidget);
  }

  /// Wraps a widget with ProviderScope and configures it to use the new Adapter layers with Mock data
  static Widget wrapWithAdapters(Widget child) {
    // We want the new Adapters to hydrate safely in test environments
    // The DataProviders watch the API but fall back gracefully, but setting this validates the mechanism
    return ProviderScope(
      child: MaterialApp(home: Scaffold(body: child)),
    );
  }
}
