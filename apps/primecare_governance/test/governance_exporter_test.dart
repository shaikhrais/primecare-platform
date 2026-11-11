import 'dart:convert';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_governance/governance/models/governance_report.dart';
import 'package:primecare_governance/governance/services/governance_exporter.dart';

void main() {
  final issue = PlatformAuditIssue(id: 'fixture-issue', screenId: 'FIXTURE_SCREEN',
    title: '<script>alert("fixture")</script>', routePath: '/fixture',
    subsystem: 'fixture', registry: 'fixture', issue: 'Missing "proof", still pending\nnext line',
    suggestion: '=HYPERLINK("fixture")', severity: AuditSeverity.high,
    owner: 'fixture-reviewer', detectedAt: DateTime.utc(2026, 1, 1));
  GovernanceReport report({bool empty = false}) => GovernanceReport(
    totalScreens: empty ? 0 : 2, totalIssues: empty ? 0 : 1,
    criticalIssues: 0, highIssues: empty ? 0 : 1, mediumIssues: 0, lowIssues: 0,
    productionReadyScreens: 0, blockedScreens: empty ? 0 : 2,
    averageTestPassRate: 0, renderOkPercent: 0, accessibilityPercent: 0,
    performancePercent: 0, issues: empty ? [] : [issue]);

  test('JSON retains actual totals, stable issue identity, route and pending work', () {
    final data = jsonDecode(GovernanceExporter.toJson(report()));
    expect(data['summary']['totalScreens'], 2);
    expect(data['summary']['blocked'], 2);
    expect(data['summary']['productionReady'], 0);
    expect(data['issues'].single['id'], issue.id);
    expect(data['issues'].single['screenId'], issue.screenId);
    expect(data['issues'].single['routePath'], issue.routePath);
    expect(data['issues'].single['message'], issue.message);
    expect(data['issues'].single['owner'], issue.owner);
    expect(data['metadata']['source'], contains('not production verification'));
  });

  test('CSV retains findings, quotes embedded text and neutralizes formulas', () {
    final csv = GovernanceExporter.toCsv(report());
    expect(csv, contains('"FIXTURE_SCREEN","/fixture"'));
    expect(csv, contains('Missing ""proof"", still pending\nnext line'));
    expect(csv, contains("\"'=HYPERLINK(\"\"fixture\"\")\""));
    expect(csv, contains('fixture-reviewer'));
  });

  test('HTML escapes finding content and never claims acceptance', () {
    final html = GovernanceExporter.toHtml(report());
    expect(html, contains('&lt;script&gt;'));
    expect(html, isNot(contains('<script>')));
    expect(html, contains('Missing &quot;proof&quot;'));
    expect(html, isNot(contains('Confirmed Integrity Milestone')));
  });

  test('Markdown contains findings and handles empty registries without NaN', () {
    final markdown = GovernanceExporter.toMarkdown(report());
    expect(markdown, contains('FIXTURE_SCREEN'));
    expect(markdown, contains('still pending'));
    final empty = GovernanceExporter.toMarkdown(report(empty: true));
    expect(empty, contains('0 / 0 (0.0%'));
    expect(empty, isNot(contains('NaN')));
  });
}
