// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_intake.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProposalIntake _$ProposalIntakeFromJson(Map<String, dynamic> json) =>
    ProposalIntake(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      requestedBy: json['requestedBy'] as String,
      department: json['department'] as String,
      office: json['office'] as String,
      role: json['role'] as String,
      priority: json['priority'] as String,
      businessGoal: json['businessGoal'] as String,
      problemStatement: json['problemStatement'] as String,
      expectedOutcome: json['expectedOutcome'] as String,
      screenId: json['screenId'] as String,
      routePath: json['routePath'] as String,
      allowedRoles: (json['allowedRoles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      requiredApis: (json['requiredApis'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      requiredComponents: (json['requiredComponents'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      requiredForms: (json['requiredForms'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      designSource: json['designSource'] as String,
      designUrl: json['designUrl'] as String,
      mockDataNotes: json['mockDataNotes'] as String,
      needsPhiData: json['needsPhiData'] as bool,
      needsConsent: json['needsConsent'] as bool,
      needsSignature: json['needsSignature'] as bool,
      needsAuditLog: json['needsAuditLog'] as bool,
      acceptanceCriteria: (json['acceptanceCriteria'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      testScenarios: (json['testScenarios'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: json['status'] as String? ?? 'proposal_received',
    );

Map<String, dynamic> _$ProposalIntakeToJson(ProposalIntake instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'requestedBy': instance.requestedBy,
      'department': instance.department,
      'office': instance.office,
      'role': instance.role,
      'priority': instance.priority,
      'businessGoal': instance.businessGoal,
      'problemStatement': instance.problemStatement,
      'expectedOutcome': instance.expectedOutcome,
      'screenId': instance.screenId,
      'routePath': instance.routePath,
      'allowedRoles': instance.allowedRoles,
      'requiredApis': instance.requiredApis,
      'requiredComponents': instance.requiredComponents,
      'requiredForms': instance.requiredForms,
      'designSource': instance.designSource,
      'designUrl': instance.designUrl,
      'mockDataNotes': instance.mockDataNotes,
      'needsPhiData': instance.needsPhiData,
      'needsConsent': instance.needsConsent,
      'needsSignature': instance.needsSignature,
      'needsAuditLog': instance.needsAuditLog,
      'acceptanceCriteria': instance.acceptanceCriteria,
      'testScenarios': instance.testScenarios,
      'createdAt': instance.createdAt.toIso8601String(),
      'status': instance.status,
    };
