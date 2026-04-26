// Layer: 01_INFRASTRUCTURE
import 'dart:convert';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_core/00_B_flutter_core.dart';

enum ReportFormat { csv, pdf }

class ReportExporter {
  final ApiClient _apiClient;

  ReportExporter(this._apiClient);

  Future<void> exportAuditReport({
    DateTime? startDate,
    DateTime? endDate,
    ReportFormat format = ReportFormat.csv,
  }) async {
    final query = {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    };

    final response = await _apiClient.get('/compliance/reports/audit', query: query);
    final responseData = response.data as Map<String, dynamic>;
    final List<dynamic> rawData = responseData['data'] as List<dynamic>;

    if (format == ReportFormat.csv) {
      await _generateAndDownloadCsv(
        filename: 'audit_report_${DateFormat('yyyyMMdd').format(DateTime.now())}.csv',
        headers: ['Timestamp', 'Actor', 'Action', 'Entity', 'Context'],
        rows: rawData.map((e) {
          final d = e as Map<String, dynamic>;
          return [
            d['timestamp'],
            d['actorEmail'],
            d['action'],
            d['entityType'],
            jsonEncode(d['metadata']),
          ];
        }).toList(),
      );
    } else {
      await _generateAndDownloadPdf(
        title: 'Institutional Audit Report',
        subtitle: 'Period: ${startDate?.toLocal() ?? "All Time"} - ${endDate?.toLocal() ?? "Present"}',
        headers: ['Timestamp', 'Actor', 'Action', 'Entity'],
        rows: rawData.map((e) {
          final d = e as Map<String, dynamic>;
          return [
            _formatPdfTimestamp(d['timestamp'] as String?),
            (d['actorEmail'] ?? 'System').toString(),
            (d['action'] ?? '').toString(),
            (d['entityType'] ?? '').toString(),
          ];
        }).toList(),
      );
    }
  }

  Future<void> exportClinicalComplianceReport({
    DateTime? startDate,
    DateTime? endDate,
    ReportFormat format = ReportFormat.csv,
  }) async {
    final query = {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    };

    final response = await _apiClient.get('/compliance/reports/clinical', query: query);
    final responseData = response.data as Map<String, dynamic>;
    final List<dynamic> rawData = responseData['data'] as List<dynamic>;

    if (format == ReportFormat.csv) {
      await _generateAndDownloadCsv(
        filename: 'clinical_compliance_${DateFormat('yyyyMMdd').format(DateTime.now())}.csv',
        headers: ['Patient', 'Metric', 'Value', 'Unit', 'Recorded At', 'Status'],
        rows: rawData.map((e) {
          final d = e as Map<String, dynamic>;
          return [
            (d['clientName'] ?? 'N/A').toString(),
            d['type'],
            d['value'],
            d['unit'],
            (d['createdAt'] ?? '').toString(),
            d['status'],
          ];
        }).toList(),
      );
    } else {
      await _generateAndDownloadPdf(
        title: 'Clinical Vitals Compliance Report',
        subtitle: 'Generated: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
        headers: ['Patient', 'Metric', 'Value', 'Recorded At'],
        rows: rawData.map((e) {
          final d = e as Map<String, dynamic>;
          return [
            (d['clientName'] ?? 'N/A').toString(),
            (d['type'] ?? '').toString(),
            '${d['value']} ${d['unit']}',
            _formatPdfTimestamp(d['createdAt'] as String?),
          ];
        }).toList(),
      );
    }
  }

  Future<void> exportStaffActivityReport({
    DateTime? startDate,
    DateTime? endDate,
    ReportFormat format = ReportFormat.csv,
  }) async {
    final query = {
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    };

    final response = await _apiClient.get('/compliance/reports/staff-activity', query: query);
    final responseData = response.data as Map<String, dynamic>;
    final List<dynamic> rawData = responseData['data'] as List<dynamic>;

    if (format == ReportFormat.csv) {
      await _generateAndDownloadCsv(
        filename: 'staff_activity_${DateFormat('yyyyMMdd').format(DateTime.now())}.csv',
        headers: ['Timestamp', 'Action', 'Email', 'Role', 'Status'],
        rows: rawData.map((e) {
          final d = e as Map<String, dynamic>;
          return [
            (d['timestamp'] ?? '').toString(),
            (d['action'] ?? '').toString(),
            (d['actorEmail'] ?? '').toString(),
            (d['metadata'] as Map?)?['roleId'] ?? 'N/A',
            (d['metadata'] as Map?)?['status'] ?? 'SUCCESS',
          ];
        }).toList(),
      );
    } else {
      await _generateAndDownloadPdf(
        title: 'Staff Provisioning & Role Activity Report',
        subtitle: 'HR Compliance Documentation',
        headers: ['Timestamp', 'Action', 'Staff Email', 'Role'],
        rows: rawData.map((e) {
          final d = e as Map<String, dynamic>;
          return [
            _formatPdfTimestamp(d['timestamp'] as String?),
            (d['action'] ?? '').toString(),
            (d['actorEmail'] ?? 'Unknown').toString(),
            ((d['metadata'] as Map?)?['roleId'] ?? 'N/A').toString(),
          ];
        }).toList(),
      );
    }
  }

  Future<void> _generateAndDownloadCsv({
    required String filename,
    required List<String> headers,
    required List<List<dynamic>> rows,
  }) async {
    final List<List<dynamic>> csvRows = [headers, ...rows];
    final buffer = StringBuffer();
    for (var row in csvRows) {
      buffer.writeln(row.join(','));
    }
    final bytes = utf8.encode(buffer.toString());

    // Using printing package to "print" as PDF is common, 
    // but for CSV on web we can use browser blobs.
    // For universal compatibility, we'll use printing.sharePdf or similar if supported,
    // otherwise we might need a web-specific blob utility.
    // However, 'printing' has a share function.

    await Printing.sharePdf(
      bytes: Uint8List.fromList(bytes),
      filename: filename,
    );
  }

  Future<void> _generateAndDownloadPdf({
    required String title,
    required String subtitle,
    required List<String> headers,
    required List<List<String>> rows,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        header: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('PrimeCare Platform', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 18, color: PdfColors.blue900)),
            pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24)),
            pw.Text(subtitle, style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
            pw.SizedBox(height: 20),
            pw.Divider(color: PdfColors.blue900, thickness: 2),
            pw.SizedBox(height: 20),
          ],
        ),
        footer: (context) => pw.Container(
          alignment: pw.Alignment.centerRight,
          margin: const pw.EdgeInsets.only(top: 10),
          child: pw.Text('Page ${context.pageNumber} of ${context.pagesCount}', style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey)),
        ),
        build: (context) => [
          pw.TableHelper.fromTextArray(
            headers: headers,
            data: rows,
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.white,
            ),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.blue900),
            cellHeight: 30,
            cellAlignments: headers.asMap().map(
                  (i, _) => MapEntry(i, pw.Alignment.centerLeft),
                ),
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: '${title.toLowerCase().replaceAll(' ', '_')}.pdf',
    );
  }

  String _formatPdfTimestamp(String? ts) {
    if (ts == null) return 'N/A';
    try {
      final dt = DateTime.parse(ts).toLocal();
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(dt);
    } catch (_) {
      return ts;
    }
  }
}

final reportExporterProvider = Provider<ReportExporter>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReportExporter(apiClient);
});
