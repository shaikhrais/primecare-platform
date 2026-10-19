import 'report_models.dart';

/// The API catalog controls visibility and capabilities; roles stay on the server.
class AdminReportDefinition {
  final String id, title, classification;
  final bool canExport, canEmail, supportsFilters;
  const AdminReportDefinition({required this.id, required this.title,
    required this.classification, required this.canExport, required this.canEmail, this.supportsFilters = false});
  factory AdminReportDefinition.fromJson(Map<String, dynamic> json) => AdminReportDefinition(
    id: json['id'] as String, title: json['title'] as String,
    classification: json['classification'] as String,
    supportsFilters: json['supportsFilters'] as bool? ?? false, canExport: json['canExport'] as bool, canEmail: json['canEmail'] as bool);
}

class AdminReportRequest {
  final String locale, search, readiness;
  const AdminReportRequest({this.locale = 'en', this.search = '', this.readiness = 'all'});
  Map<String, String> toJson() => {'locale': locale, 'search': search, 'readiness': readiness};
}

/// Keeps the existing ReportData contract while adding report provenance.
class AdminReportResult extends ReportData {
  final DateTime generatedAt;
  final String scope, classification, locale, source;
  AdminReportResult({required super.id, required super.title,
    required super.columns, required super.rows, required this.generatedAt,
    required this.scope, required this.classification, required this.locale,
    required this.source});
  factory AdminReportResult.fromJson(Map<String, dynamic> json) {
    if (json['isOffline'] == true) throw const FormatException('Offline report is not exportable');
    final data = ReportData.fromJson(json);
    return AdminReportResult(id: data.id, title: data.title, columns: data.columns,
      rows: data.rows, generatedAt: DateTime.parse(json['generatedAt'] as String),
      scope: json['scope'] as String, classification: json['classification'] as String,
      locale: json['locale'] as String, source: json['source'] as String);
  }
}
