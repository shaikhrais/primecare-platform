import 'package:json_annotation/json_annotation.dart';

part 'proposal_intake.g.dart';

@JsonSerializable()
class ProposalIntake {
  final String id;
  final String title;
  final String description;
  final String requestedBy;
  final String department;
  final String office;
  final String role;
  final String priority; // p0, p1, p2, p3

  final String businessGoal;
  final String problemStatement;
  final String expectedOutcome;

  final String screenId;
  final String routePath;
  final List<String> allowedRoles;

  final List<String> requiredApis;
  final List<String> requiredComponents;
  final List<String> requiredForms;

  final String designSource; // stitch, figma, screenshot, text
  final String designUrl;
  final String mockDataNotes;

  final bool needsPhiData;
  final bool needsConsent;
  final bool needsSignature;
  final bool needsAuditLog;

  final List<String> acceptanceCriteria;
  final List<String> testScenarios;

  final DateTime createdAt;
  final String status; // proposal_received, in_review, approved, production, rejected

  const ProposalIntake({
    required this.id,
    required this.title,
    required this.description,
    required this.requestedBy,
    required this.department,
    required this.office,
    required this.role,
    required this.priority,
    required this.businessGoal,
    required this.problemStatement,
    required this.expectedOutcome,
    required this.screenId,
    required this.routePath,
    required this.allowedRoles,
    required this.requiredApis,
    required this.requiredComponents,
    required this.requiredForms,
    required this.designSource,
    required this.designUrl,
    required this.mockDataNotes,
    required this.needsPhiData,
    required this.needsConsent,
    required this.needsSignature,
    required this.needsAuditLog,
    required this.acceptanceCriteria,
    required this.testScenarios,
    required this.createdAt,
    this.status = 'proposal_received',
  });

  factory ProposalIntake.fromJson(Map<String, dynamic> json) => _$ProposalIntakeFromJson(json);
  Map<String, dynamic> toJson() => _$ProposalIntakeToJson(this);

  ProposalIntake copyWith({
    String? title,
    String? description,
    String? requestedBy,
    String? department,
    String? office,
    String? role,
    String? priority,
    String? businessGoal,
    String? problemStatement,
    String? expectedOutcome,
    String? screenId,
    String? routePath,
    List<String>? allowedRoles,
    List<String>? requiredApis,
    List<String>? requiredComponents,
    List<String>? requiredForms,
    String? designSource,
    String? designUrl,
    String? mockDataNotes,
    bool? needsPhiData,
    bool? needsConsent,
    bool? needsSignature,
    bool? needsAuditLog,
    List<String>? acceptanceCriteria,
    List<String>? testScenarios,
    String? status,
  }) {
    return ProposalIntake(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      requestedBy: requestedBy ?? this.requestedBy,
      department: department ?? this.department,
      office: office ?? this.office,
      role: role ?? this.role,
      priority: priority ?? this.priority,
      businessGoal: businessGoal ?? this.businessGoal,
      problemStatement: problemStatement ?? this.problemStatement,
      expectedOutcome: expectedOutcome ?? this.expectedOutcome,
      screenId: screenId ?? this.screenId,
      routePath: routePath ?? this.routePath,
      allowedRoles: allowedRoles ?? this.allowedRoles,
      requiredApis: requiredApis ?? this.requiredApis,
      requiredComponents: requiredComponents ?? this.requiredComponents,
      requiredForms: requiredForms ?? this.requiredForms,
      designSource: designSource ?? this.designSource,
      designUrl: designUrl ?? this.designUrl,
      mockDataNotes: mockDataNotes ?? this.mockDataNotes,
      needsPhiData: needsPhiData ?? this.needsPhiData,
      needsConsent: needsConsent ?? this.needsConsent,
      needsSignature: needsSignature ?? this.needsSignature,
      needsAuditLog: needsAuditLog ?? this.needsAuditLog,
      acceptanceCriteria: acceptanceCriteria ?? this.acceptanceCriteria,
      testScenarios: testScenarios ?? this.testScenarios,
      createdAt: createdAt,
      status: status ?? this.status,
    );
  }
}
