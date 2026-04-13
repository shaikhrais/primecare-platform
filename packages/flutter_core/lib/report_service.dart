import 'network/api_client.dart';

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

  ReportData({
    required this.id,
    required this.title,
    required this.columns,
    required this.rows,
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
    );
  }
}

class ReportService {
  final ApiClient _apiClient;

  ReportService(this._apiClient);

  Future<ReportData> getReport(String reportId) async {
    try {
      // In the future, this would hit a dedicated reporting endpoint
      // For now, we utilize the standardized client for dynamic hydration
      final endpoint = '/api/reports/$reportId';
      final response = await _apiClient.get(endpoint);

      if (response.statusCode == 200) {
        return ReportData.fromJson(response.data as Map<String, dynamic>);
      }
      throw Exception(
        'Failed to load report $reportId: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('Failed to fetch report data for ID $reportId: $e');
    }
  }
}
