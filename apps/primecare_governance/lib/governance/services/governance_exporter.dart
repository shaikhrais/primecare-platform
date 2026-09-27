// Governance - Category: service | Purpose: Generates a Markdown representation of the governance report
import 'dart:convert';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/governance_report.dart';

class GovernanceExporter {
  /// Generates a Markdown representation of the governance report
  static String toMarkdown(GovernanceReport report) {
    final buffer = StringBuffer();

    buffer.writeln('# PrimeCare Platform Governance Report');
    buffer.writeln('Generated: ${DateTime.now().toString().split('.')[0]}');
    buffer.writeln('');

    buffer.writeln('## 1. Executive Summary');
    buffer.writeln('| Metric | Value |');
    buffer.writeln('| :--- | :--- |');
    buffer.writeln('| Total Screens | ${report.totalScreens} |');
    buffer.writeln('| Overall Issues | ${report.totalIssues} |');
    buffer.writeln('| Critical Issues | ${report.criticalIssues} |');
    buffer.writeln(
      '| Production Ready | ${report.productionReadyScreens} / ${report.totalScreens} (${report.productionReadyScreens / report.totalScreens * 100}% ) |',
    );
    buffer.writeln(
      '| Avg Test Pass Rate | ${report.averageTestPassRate.toStringAsFixed(1)}% |',
    );
    buffer.writeln('');

    buffer.writeln('## 2. Platform Quality Gates');
    buffer.writeln(
      '- **Render Health:** ${report.renderOkPercent.toStringAsFixed(1)}%',
    );
    buffer.writeln(
      '- **Accessibility:** ${report.accessibilityPercent.toStringAsFixed(1)}%',
    );
    buffer.writeln(
      '- **Performance:** ${report.performancePercent.toStringAsFixed(1)}%',
    );
    buffer.writeln('');

    buffer.writeln('## 3. Detected Architectural Issues');
    buffer.writeln('| Severity | Category | Screen | Issue | Fix |');
    buffer.writeln('| :--- | :--- | :--- | :--- | :--- |');

    for (final issue in report.issues) {
      buffer.writeln(
        '| ${issue.severity.name.toUpperCase()} | ${issue.category.name.toUpperCase()} | ${issue.title} | ${issue.message} | ${issue.suggestedFix} |',
      );
    }

    buffer.writeln('');
    buffer.writeln('---');
    buffer.writeln('PrimeCare Governance Engine v1.0.0');

    return buffer.toString();
  }

  /// Generates a JSON representation of the report
  static String toJson(GovernanceReport report) {
    return jsonEncode({
      'metadata': {
        'generatedAt': DateTime.now().toIso8601String(),
        'engineVersion': '1.0.0',
      },
      'summary': {
        'totalScreens': report.totalScreens,
        'totalIssues': report.totalIssues,
        'severityBreakdown': {
          'critical': report.criticalIssues,
          'high': report.highIssues,
          'medium': report.mediumIssues,
          'low': report.lowIssues,
        },
        'productionReady': report.productionReadyScreens,
        'blocked': report.blockedScreens,
      },
      'qualityGates': {
        'avgTestPassRate': report.averageTestPassRate,
        'renderOkPercent': report.renderOkPercent,
        'accessibilityPercent': report.accessibilityPercent,
        'performancePercent': report.performancePercent,
      },
      'issues': report.issues
          .map(
            (i) => {
              'screenId': i.screenId,
              'severity': i.severity.name,
              'category': i.category.name,
              'message': i.message,
              'suggestedFix': i.suggestedFix,
              'owner': i.owner,
              'detectedAt': i.detectedAt.toIso8601String(),
            },
          )
          .toList(),
    });
  }

  /// Generates a CSV representation of the issues
  static String toCsv(GovernanceReport report) {
    final buffer = StringBuffer();
    buffer.writeln(
      'Severity,Category,Screen,Route,Message,Fix,Owner,DetectedAt',
    );

    for (final i in report.issues) {
      final line = [
        i.severity.name,
        i.category.name,
        '"${i.title}"',
        i.routePath,
        '"${i.message}"',
        '"${i.suggestedFix}"',
        i.owner,
        i.detectedAt.toIso8601String(),
      ].join(',');
      buffer.writeln(line);
    }

    return buffer.toString();
  }

  /// Generates a high-fidelity HTML representation of the report
  static String toHtml(GovernanceReport report) {
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>PrimeCare Governance Report</title>
    <style>
        body { font-family: 'Inter', sans-serif; line-height: 1.6; color: #333; max-width: 1000px; margin: 40px auto; padding: 0 20px; }
        .header { border-bottom: 2px solid #0052cc; padding-bottom: 20px; margin-bottom: 40px; }
        h1 { color: #0052cc; margin: 0; }
        .meta { color: #666; font-size: 14px; }
        .summary-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 40px; }
        .summary-card { background: #f4f7fa; padding: 20px; border-radius: 12px; text-align: center; border: 1px solid #e1e4e8; }
        .summary-card .value { font-size: 24px; font-weight: bold; color: #0052cc; }
        .summary-card .label { font-size: 12px; color: #666; text-transform: uppercase; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 40px; }
        th { background: #f4f7fa; text-align: left; padding: 12px; border-bottom: 2px solid #e1e4e8; font-size: 13px; }
        td { padding: 12px; border-bottom: 1px solid #e1e4e8; font-size: 13px; }
        .severity { font-weight: bold; padding: 4px 8px; border-radius: 4px; font-size: 11px; }
        .severity-critical { background: #ffebee; color: #c62828; }
        .severity-high { background: #fff3e0; color: #e65100; }
        .severity-medium { background: #e3f2fd; color: #1565c0; }
        .severity-low { background: #f1f8e9; color: #33691e; }
        .footer { border-top: 1px solid #e1e4e8; padding-top: 20px; color: #999; font-size: 12px; text-align: center; }
    </style>
</head>
<body>
    <div class="header">
        <h1>PrimeCare Platform Governance Report</h1>
        <div class="meta">Generated: ${DateTime.now().toString().split('.')[0]} | Engine Version: 1.0.0</div>
    </div>

    <h2>Executive Summary</h2>
    <div class="summary-grid">
        <div class="summary-card">
            <div class="value">${report.totalScreens}</div>
            <div class="label">Total Screens</div>
        </div>
        <div class="summary-card">
            <div class="value">${report.overallHealthScore.toStringAsFixed(1)}%</div>
            <div class="label">Health Score</div>
        </div>
        <div class="summary-card">
            <div class="value">${report.criticalIssues}</div>
            <div class="label">Critical Issues</div>
        </div>
        <div class="summary-card">
            <div class="value">${report.productionReadyScreens}</div>
            <div class="label">Ready Screens</div>
        </div>
    </div>

    <h2>Architectural Findings</h2>
    <table>
        <thead>
            <tr>
                <th>Severity</th>
                <th>Category</th>
                <th>Screen</th>
                <th>Violation</th>
                <th>Remediation</th>
            </tr>
        </thead>
        <tbody>
            ${report.issues.map((i) => '''
            <tr>
                <td><span class="severity severity-${i.severity.name}">${i.severity.name.toUpperCase()}</span></td>
                <td>${i.category.name.toUpperCase()}</td>
                <td>${i.title}</td>
                <td>${i.message}</td>
                <td>${i.suggestedFix}</td>
            </tr>
            ''').join('')}
        </tbody>
    </table>

    <div class="footer">
        © ${DateTime.now().year} PrimeCare Architectural Governance Engine. Confirmed Integrity Milestone.
    </div>
</body>
</html>
    ''';
  }

  /// Generates a high-fidelity PDF representation of the report
  static Future<Uint8List> toPdf(GovernanceReport report) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'PrimeCare Platform Governance Report',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.blue,
                  ),
                ),
                pw.Text(
                  'v1.0.0',
                  style: const pw.TextStyle(color: PdfColors.grey),
                ),
              ],
            ),
          ),
          pw.Paragraph(
            text: 'Generated: ${DateTime.now().toString().split('.')[0]}',
          ),

          pw.Header(level: 1, text: 'Executive Summary'),
          pw.TableHelper.fromTextArray(
            headers: ['Metric', 'Value'],
            data: [
              ['Total Screens', report.totalScreens.toString()],
              [
                'Overall Health Score',
                '${report.overallHealthScore.toStringAsFixed(1)}%',
              ],
              ['Critical Issues', report.criticalIssues.toString()],
              [
                'Production Ready',
                '${report.productionReadyScreens} / ${report.totalScreens}',
              ],
              [
                'Avg Test Pass Rate',
                '${report.averageTestPassRate.toStringAsFixed(1)}%',
              ],
            ],
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
          ),

          pw.Header(level: 1, text: 'Architectural Findings'),
          pw.TableHelper.fromTextArray(
            headers: ['Severity', 'Category', 'Screen', 'Violation'],
            data: report.issues
                .map(
                  (i) => [
                    i.severity.name.toUpperCase(),
                    i.category.name.toUpperCase(),
                    i.title,
                    i.message,
                  ],
                )
                .toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            cellAlignment: pw.Alignment.centerLeft,
          ),

        ],
        footer: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(top: 10),
            child: pw.Text(
              'Page ${context.pageNumber} of ${context.pagesCount}',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey),
            ),
          );
        },
      ),
    );

    return pdf.save();
  }
}
