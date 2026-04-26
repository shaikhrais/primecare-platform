// Layer: 01_INFRASTRUCTURE
import 'package:primecare_adapters/primecare_adapters.dart';

class ReportColumn {
  final String key;
  final String label;
  final bool isNumeric;

  ReportColumn({
    required this.key,
    required this.label,
    this.isNumeric = false,
  });

  factory ReportColumn.fromJson(Map<String, dynamic> json) {
    return ReportColumn(
      key: json['key'] as String,
      label: json['label'] as String,
      isNumeric: json['isNumeric'] as bool? ?? false,
    );
  }
}

class ReportRow {
  final Map<String, dynamic> cells;

  ReportRow({required this.cells});

  dynamic operator [](String key) => cells[key];

  factory ReportRow.fromJson(Map<String, dynamic> json) {
    return ReportRow(cells: json);
  }
}

class ReportData {
  final String id;
  final String title;
  final List<ReportColumn> columns;
  final List<ReportRow> rows;
  final bool isOffline;

  ReportData({
    required this.id,
    required this.title,
    required this.columns,
    required this.rows,
    this.isOffline = false,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) {
    return ReportData(
      id: json['id'] as String,
      title: json['title'] as String,
      columns: (json['columns'] as List)
          .map((i) => ReportColumn.fromJson(i as Map<String, dynamic>))
          .toList(),
      rows: (json['rows'] as List)
          .map((i) => ReportRow.fromJson(i as Map<String, dynamic>))
          .toList(),
      isOffline: json['isOffline'] as bool? ?? false,
    );
  }

  factory ReportData.empty({String? id, String? title, bool isOffline = true}) {
    return ReportData(
      id: id ?? 'empty',
      title: title ?? 'No Data Available',
      columns: [],
      rows: [],
      isOffline: isOffline,
    );
  }
}

class ReportService {
  final ApiClient _apiClient;
  final ExecutionGateService _telemetry;

  ReportService(this._apiClient, this._telemetry);

  Future<Result<ReportData>> getReport(String reportId) async {
    return Result.guardFuture<ReportData>(
      () async {
        final endpoint = '/api/reports/$reportId';
        final response = await _apiClient.get(endpoint);

        if (response.statusCode == 200) {
          _telemetry.passGate(
            ExecutionGateCategory.metricsLayer,
            'Report fetched successfully: $reportId',
            metadata: {'reportId': reportId},
          );
          return ReportData.fromJson(response.data as Map<String, dynamic>);
        }

        _telemetry.passGate(
          ExecutionGateCategory.metricsLayer,
          'Report fetch returned empty (Status: ${response.statusCode})',
          metadata: {'reportId': reportId},
        );

        return ReportData.empty(
          id: reportId,
          title: 'Report Load Failure (${response.statusCode})',
          isOffline: true,
        );
      },
      onError: (Object e, StackTrace st) {
        _telemetry.failGate(
          ExecutionGateCategory.metricsLayer,
          'Failed to fetch report: $reportId',
          error: e,
          stackTrace: st,
          metadata: {'reportId': reportId},
        );
        // Resilient fallback: Return an empty shell
        return ReportData.empty(id: reportId, isOffline: true);
      },
    );
  }
}
