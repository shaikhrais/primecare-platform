import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
    final titleWidget = tester.widget<Text>(pageTitle);
    expect(titleWidget.data, expectedTitle);
  }

  Future<void> verifySubtitle(String expectedSubtitle) async {
    final subtitleWidget = tester.widget<Text>(pageSubtitle);
    expect(subtitleWidget.data, expectedSubtitle);
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
}
