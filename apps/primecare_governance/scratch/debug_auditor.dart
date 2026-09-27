// Governance - Category: service | Purpose: Core implementation file for the Debug Auditor platform logic.
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:primecare_governance/governance/services/cross_subsystem_auditor.dart';

void main() async {
  print('CWD: ${Directory.current.path}');
  final auditor = CrossSubsystemAuditor(projectRoot: '../..');

  print('Running audit...');
  final screenIssues = await auditor.auditScreenRegistryParity();

  print('Found ${screenIssues.length} screen issues.');
  for (final issue in screenIssues) {
    print(' - ${issue.issue}');
  }
}
