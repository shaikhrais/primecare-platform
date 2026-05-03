import 'governance_category.dart';
import 'governance_severity.dart';

class GovernanceIssue {
  final String screenId;
  final String title;
  final String routePath;
  final GovernanceCategory category;
  final GovernanceSeverity severity;
  final String message;
  final String fix;
  final String owner;
  final String sprintName;
  final String? sourcePath;
  final String? fixProperty;
  final String? fixValue;
  final DateTime detectedAt;

  const GovernanceIssue({
    required this.screenId,
    required this.title,
    required this.routePath,
    required this.category,
    required this.severity,
    required this.message,
    required this.fix,
    required this.owner,
    required this.sprintName,
    this.sourcePath,
    this.fixProperty,
    this.fixValue,
    required this.detectedAt,
  });
}
