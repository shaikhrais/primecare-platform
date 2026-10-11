import 'dart:typed_data';
import 'package:flutter_core/flutter_core.dart' show ApiClient;
import 'package:primecare_models/primecare_models.dart';

class AdminReportCatalog {
  final List<AdminReportDefinition> reports;
  final Map<String, String> resources;
  AdminReportCatalog.fromJson(Map<String, dynamic> json)
    : reports = (json['reports'] as List).map((r) => AdminReportDefinition.fromJson(Map<String,dynamic>.from(r as Map))).toList(),
      resources = Map<String, String>.from(json['resources'] as Map);
}

/// Central transport for all admin report screens. No cached or offline reports.
class AdminReportService {
  final ApiClient client;
  final String endpoint;
  AdminReportService(this.client, this.endpoint) {
    if (endpoint != '/v1/governance/reports') throw ArgumentError('Invalid report endpoint');
  }
  String route(String id, AdminReportRequest options, [String suffix = '']) {
    if (!RegExp(r'^[a-z_]+$').hasMatch(id)) throw ArgumentError('Invalid report id');
    return '$endpoint/$id$suffix?${Uri(queryParameters: options.toJson()).query}';
  }
  Future<AdminReportCatalog> catalog(String locale) async {
    final response = await client.get(endpoint, queryParameters: {'locale':locale});
    if (response.statusCode != 200 || response.data is! Map) throw StateError('Report catalog unavailable');
    return AdminReportCatalog.fromJson(Map<String,dynamic>.from(response.data as Map));
  }
  Future<AdminReportResult> run(String id, AdminReportRequest options) async {
    final response = await client.get(route(id, options));
    if (response.statusCode != 200 || response.data is! Map) throw StateError('Report unavailable');
    return AdminReportResult.fromJson(Map<String,dynamic>.from(response.data as Map));
  }
  Future<Uint8List> pdf(String id, AdminReportRequest options) async {
    final response = await client.downloadBytes(route(id, options, '/pdf'));
    if (response.statusCode != 200 || response.data is! List<int>) throw StateError('PDF unavailable');
    final bytes = Uint8List.fromList(response.data as List<int>);
    if (bytes.length < 8 || String.fromCharCodes(bytes.take(5)) != '%PDF-') throw const FormatException('Invalid PDF');
    return bytes;
  }
  Future<String> email(String id, AdminReportRequest options, {required String to,
    required String subject, required String message, required bool confirmed,
    required String idempotencyKey}) async {
    if (!RegExp(r'^[a-z_]+$').hasMatch(id)) throw ArgumentError('Invalid report id');
    final response = await client.post('$endpoint/$id/email', body: {
      ...options.toJson(), 'to':to, 'subject':subject, 'message':message, 'confirmed':confirmed,
    }, headers: {'Idempotency-Key':idempotencyKey});
    final state = response.data is Map ? (response.data as Map)['state'] : null;
    if (state == 'accepted' && [200,202].contains(response.statusCode)) return 'accepted';
    if (state == 'unknown' || state == 'sending') return 'unknown';
    throw StateError('Report email unavailable');
  }
}
