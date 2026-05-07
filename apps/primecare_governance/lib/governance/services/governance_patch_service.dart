import '../models/governance_issue.dart';

class GovernancePatchService {
  /// Generates a "Remediation Script" that can be copy-pasted into the registry.
  /// For now, it returns a formatted string with the suggested metadata changes.
  static String generateRemediationScript(List<GovernanceIssue> issues) {
    if (issues.isEmpty) return '// No remediation required.';

    final buffer = StringBuffer();
    buffer.writeln('// --- PrimeCare Architectural Remediation Patch ---');
    buffer.writeln('// Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln('// Applied to: lib/core/governance/screen_registry.dart');
    buffer.writeln('');

    final issuesByScreen = <String, List<GovernanceIssue>>{};
    for (final issue in issues) {
      issuesByScreen.putIfAbsent(issue.screenId, () => []).add(issue);
    }

    issuesByScreen.forEach((screenId, screenIssues) {
      buffer.writeln('// REMEDIATION FOR: $screenId');
      for (final issue in screenIssues) {
        buffer.writeln('// Issue: ${issue.message}');
        buffer.writeln('// Fix: ${issue.fix}');
      }
      buffer.writeln('// Recommended Registry Patch Snippet:');
      buffer.writeln("  '$screenId': ScreenMetadata(");
      buffer.writeln("    id: '$screenId',");
      buffer.writeln("    // ... update fields below ...");
      buffer.writeln("  ),");
      buffer.writeln('');
    });

    return buffer.toString();
  }

  /// In a more advanced implementation, this could use `dart:io` to
  /// programmatically patch the registry file using `String.replaceFirst`.
  static Future<bool> applyQuickFix(GovernanceIssue issue) async {
    // For now, this is a simulated fix.
    // Real implementation would require parsing the registry file.
    return true;
  }
}
