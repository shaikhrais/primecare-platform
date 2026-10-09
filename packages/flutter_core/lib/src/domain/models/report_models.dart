import 'base_entity.dart';
// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE

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

class ReportData extends BaseEntity<String> {
  final String title;
  final List<ReportColumn> columns;
  final List<ReportRow> rows;
  final bool isOffline;

  ReportData({
    required super.id,
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
