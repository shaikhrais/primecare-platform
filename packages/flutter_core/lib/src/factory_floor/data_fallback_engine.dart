import 'ui_blueprint.dart';

/// Universal mock objects for the fallback engine
class UniversalKpi {
  final String title;
  final String value;
  final String? trend;
  final String status;

  const UniversalKpi({
    required this.title,
    required this.value,
    this.trend,
    required this.status,
  });
}

class UniversalActivityLog {
  final String title;
  final DateTime timestamp;

  const UniversalActivityLog({required this.title, required this.timestamp});
}

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
      id: 'fallback_stats',
      title: title,
      dataPayload: const [
        UniversalKpi(title: 'Revenue (Offline)', value: '\$0', trend: '-', status: 'Warning'),
        UniversalKpi(title: 'Active Clients', value: '-', trend: '-', status: 'Warning'),
        UniversalKpi(title: 'Pending Tasks', value: 'Offline', trend: '-', status: 'Warning'),
        UniversalKpi(title: 'System Status', value: 'Degraded', trend: '-', status: 'Critical'),
      ],
    );
  }

  /// Generates a fallback activity feed blueprint indicating missing/offline data.
  static ActivityFeedBlueprint createFallbackActivityFeed(String title) {
    return ActivityFeedBlueprint(
      id: 'fallback_activity',
      title: title,
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
      id: 'fallback_table',
      title: title,
      dataPayload: const [
        UniversalDataRow(
          title: 'Connection Offline',
          description: 'Cannot retrieve data table logs at this time.',
        ),
      ],
    );
  }
}
