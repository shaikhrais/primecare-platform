import '../models/proposal_intake.dart';

class ProposalCollectorService {
  /// Validates a proposal according to PrimeCare Governance rules.
  static List<String> validate(ProposalIntake proposal) {
    final errors = <String>[];

    if (proposal.title.trim().isEmpty) {
      errors.add('Proposal title is required.');
    }

    if (proposal.businessGoal.trim().isEmpty) {
      errors.add('Business goal is required.');
    }

    if (!proposal.routePath.startsWith('/')) {
      errors.add('Route path must start with /.');
    }

    if (proposal.allowedRoles.isEmpty) {
      errors.add('At least one allowed role is required.');
    }

    if (proposal.acceptanceCriteria.isEmpty) {
      errors.add('Acceptance criteria is required.');
    }

    if (proposal.testScenarios.isEmpty) {
      errors.add('At least one test scenario is required.');
    }

    if (proposal.needsPhiData && !proposal.needsAuditLog) {
      errors.add('PHI data requires audit log.');
    }

    return errors;
  }

  /// Checks if a proposal is ready for production.
  static bool isReadyForProduction(ProposalIntake proposal) {
    final validationErrors = validate(proposal);
    if (validationErrors.isNotEmpty) return false;

    // Additional "hard rule" checks from the request
    if (proposal.screenId.isEmpty) return false;
    if (proposal.requiredApis.isEmpty) return false;
    if (proposal.requiredComponents.isEmpty) return false;
    if (proposal.status != 'approved') return false;

    return true;
  }

  /// Calculates a "Readiness Score" based on filled fields.
  static double calculateReadiness(ProposalIntake proposal) {
    int filledFields = 0;
    const int totalRequired = 9;

    if (proposal.businessGoal.isNotEmpty) filledFields++;
    if (proposal.screenId.isNotEmpty && proposal.routePath.isNotEmpty) filledFields++;
    if (proposal.allowedRoles.isNotEmpty) filledFields++;
    if (proposal.requiredApis.isNotEmpty) filledFields++;
    if (proposal.requiredComponents.isNotEmpty) filledFields++;
    if (proposal.acceptanceCriteria.isNotEmpty) filledFields++;
    if (proposal.testScenarios.isNotEmpty) filledFields++;
    if (!proposal.needsPhiData || proposal.needsAuditLog) filledFields++;
    if (proposal.status == 'approved') filledFields++;

    return filledFields / totalRequired;
  }
}
