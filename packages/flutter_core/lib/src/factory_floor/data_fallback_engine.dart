import 'ui_blueprint.dart';

/// Universal activity logs for the fallback engine
class UniversalActivityLog {
  final String title;
  final DateTime timestamp;

  const UniversalActivityLog({required this.title, required this.timestamp});
}

/// Universal data rows for the fallback engine
class UniversalDataRow {
  final String title;
  final String description;

  const UniversalDataRow({required this.title, required this.description});
}

/// A centralized engine to generate gracefully degraded "Fallback" blueprints
/// when the API is unreachable, times out, or returns severely malformed data.
class DataFallbackEngine {
  /// Generates a fallback stat grid blueprint indicating missing/offline data.
  static StatGridBlueprint createFallbackStatGrid(String title) {
    return StatGridBlueprint(
      dataPayload: const [
        UniversalKpi(
          title: 'Revenue (Offline)',
          value: r'$0',
          trend: 0.0,
          status: KpiStatus.warning,
        ),
        UniversalKpi(
          title: 'Active Clients',
          value: '-',
          trend: 0.0,
          status: KpiStatus.warning,
        ),
        UniversalKpi(
          title: 'Pending Tasks',
          value: 'Offline',
          trend: 0.0,
          status: KpiStatus.warning,
        ),
        UniversalKpi(
          title: 'System Status',
          value: 'Degraded',
          trend: 0.0,
          status: KpiStatus.critical,
        ),
      ],
    );
  }

  /// Generates a fallback activity feed blueprint indicating missing/offline data.
  static ActivityFeedBlueprint createFallbackActivityFeed(String title) {
    return ActivityFeedBlueprint(
      dataPayload: [
        UniversalActivityLog(
          title: 'System operating in degraded mode.',
          timestamp: DateTime.now(),
        ),
      ],
    );
  }

  /// Generates a fallback data table
  static DataTableBlueprint createFallbackDataTable(String title) {
    return DataTableBlueprint(
      dataPayload: const [
        UniversalDataRow(
          title: 'Connection Offline',
          description: 'Cannot retrieve data table logs at this time.',
        ),
      ],
    );
  }
}
