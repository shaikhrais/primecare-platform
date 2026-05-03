import 'package:drift/drift.dart';
import 'dart:convert';
import '../../../core/database/governance_database.dart';
import '../models/proposal_intake.dart';

class ProposalRepository {
  final GovernanceDatabase _db;

  ProposalRepository(this._db);

  Future<List<ProposalIntake>> getAll() async {
    final rows = await _db.getAllProposals();
    return rows.map((row) => _mapToModel(row)).toList();
  }

  Future<void> save(ProposalIntake proposal) async {
    await _db.upsertProposal(_mapToCompanion(proposal));
  }

  Future<void> delete(String id) async {
    await _db.deleteProposal(id);
  }

  ProposalIntake _mapToModel(Proposal row) {
    return ProposalIntake(
      id: row.id,
      title: row.title,
      description: row.description,
      requestedBy: row.requestedBy,
      department: row.department,
      office: row.office,
      role: row.role,
      priority: row.priority,
      businessGoal: row.businessGoal,
      problemStatement: row.problemStatement,
      expectedOutcome: row.expectedOutcome,
      screenId: row.screenId,
      routePath: row.routePath,
      allowedRoles: List<String>.from(jsonDecode(row.allowedRoles)),
      requiredApis: List<String>.from(jsonDecode(row.requiredApis)),
      requiredComponents: List<String>.from(jsonDecode(row.requiredComponents)),
      requiredForms: List<String>.from(jsonDecode(row.requiredForms)),
      designSource: row.designSource,
      designUrl: row.designUrl,
      mockDataNotes: row.mockDataNotes,
      needsPhiData: row.needsPhiData,
      needsConsent: row.needsConsent,
      needsSignature: row.needsSignature,
      needsAuditLog: row.needsAuditLog,
      acceptanceCriteria: List<String>.from(jsonDecode(row.acceptanceCriteria)),
      testScenarios: List<String>.from(jsonDecode(row.testScenarios)),
      createdAt: row.createdAt,
      status: row.status,
    );
  }

  ProposalsCompanion _mapToCompanion(ProposalIntake model) {
    return ProposalsCompanion(
      id: Value(model.id),
      title: Value(model.title),
      description: Value(model.description),
      requestedBy: Value(model.requestedBy),
      department: Value(model.department),
      office: Value(model.office),
      role: Value(model.role),
      priority: Value(model.priority),
      businessGoal: Value(model.businessGoal),
      problemStatement: Value(model.problemStatement),
      expectedOutcome: Value(model.expectedOutcome),
      screenId: Value(model.screenId),
      routePath: Value(model.routePath),
      allowedRoles: Value(jsonEncode(model.allowedRoles)),
      requiredApis: Value(jsonEncode(model.requiredApis)),
      requiredComponents: Value(jsonEncode(model.requiredComponents)),
      requiredForms: Value(jsonEncode(model.requiredForms)),
      designSource: Value(model.designSource),
      designUrl: Value(model.designUrl),
      mockDataNotes: Value(model.mockDataNotes),
      needsPhiData: Value(model.needsPhiData),
      needsConsent: Value(model.needsConsent),
      needsSignature: Value(model.needsSignature),
      needsAuditLog: Value(model.needsAuditLog),
      acceptanceCriteria: Value(jsonEncode(model.acceptanceCriteria)),
      testScenarios: Value(jsonEncode(model.testScenarios)),
      createdAt: Value(model.createdAt),
      status: Value(model.status),
    );
  }
}
