import 'dart:io';

void main() {
  final file = File(
    'apps/primecare_governance/lib/core/governance/screen_registry.dart',
  );
  if (!file.existsSync()) {
    print('Registry not found');
    return;
  }

  var content = file.readAsStringSync();

  // 1. Dashboards remediation
  final dashboardRegex = RegExp(
    r"(title: '.*?Dashboard',[\s\S]*?pendingComponents: \[)(.*?)(\],)",
    multiLine: true,
  );

  content = content.replaceAllMapped(dashboardRegex, (match) {
    var pending = match.group(2) ?? '';
    if (!pending.contains('PrimeCareResponsiveKpiGrid')) {
      if (pending.isEmpty) {
        pending =
            "'PrimeCareResponsiveKpiGrid', 'PrimeCareChartCard', 'IntelligenceInsightCard', 'MasterLayout'";
      } else {
        pending +=
            ", 'PrimeCareResponsiveKpiGrid', 'PrimeCareChartCard', 'IntelligenceInsightCard', 'MasterLayout'";
      }
    }
    return '${match.group(1)}$pending${match.group(3)}';
  });

  // 2. Forms remediation
  final formsRegex = RegExp(
    r"(title: '.*?(?:Forms|Onboarding).*?',[\s\S]*?pendingComponents: \[)(.*?)(\],)",
    multiLine: true,
  );

  content = content.replaceAllMapped(formsRegex, (match) {
    var pending = match.group(2) ?? '';
    if (!pending.contains('PrimeCareFormBuilder')) {
      if (pending.isEmpty) {
        pending =
            "'PrimeCareFormBuilder', 'HealthcareSignaturePad', 'ValidationSummary'";
      } else {
        pending +=
            ", 'PrimeCareFormBuilder', 'HealthcareSignaturePad', 'ValidationSummary'";
      }
    }
    return '${match.group(1)}$pending${match.group(3)}';
  });

  // 3. Technical Monitors / Audit remediation
  final technicalRegex = RegExp(
    r"(title: '.*?(?:Monitor|Audit).*?',[\s\S]*?pendingComponents: \[)(.*?)(\],)",
    multiLine: true,
  );

  content = content.replaceAllMapped(technicalRegex, (match) {
    var pending = match.group(2) ?? '';
    if (!pending.contains('RealTimeTelemetryGraph')) {
      if (pending.isEmpty) {
        pending =
            "'RealTimeTelemetryGraph', 'SystemHealthGauge', 'ExportAuditLogButton'";
      } else {
        pending +=
            ", 'RealTimeTelemetryGraph', 'SystemHealthGauge', 'ExportAuditLogButton'";
      }
    }
    return '${match.group(1)}$pending${match.group(3)}';
  });

  file.writeAsStringSync(content);
  print('Registry remediation complete.');
}
