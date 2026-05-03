import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/proposal_intake.dart';

import '../../../core/governance/governance_provider.dart';

/// [StitchBridgeService] - Manages the interaction with the Stitch UI Engine.
/// This service acts as the gateway between PrimeCare Governance blueprints
/// and the high-fidelity UI generation engine.
class StitchBridgeService {
  final Ref ref;

  StitchBridgeService(this.ref);

  /// The target project ID in Stitch for Executive/Clinical Dashboards.
  static const String targetProjectId = '15314435792847062846';

  /// Triggers a screen generation request.
  /// This method constructs the final engineering prompt from the proposal metadata.
  Future<String> generateScreen(ProposalIntake proposal) async {
    // final collectionService = ref.read(proposalDataCollectionServiceProvider);
    // final prompt = collectionService.toStitchPrompt(proposal);
    
    // Add governance telemetry
    ref.read(governanceProvider.notifier).logEvent(
      'STITCH_REQUEST',
      'Triggering generation for: ${proposal.title} (ID: ${proposal.screenId}). Office: ${proposal.office}',
      GovernanceEventLevel.info,
    );

    // In a production environment, this would call the Stitch MCP or API.
    // The agent (Antigravity) will detect this request and execute the tool.
    return 'STITCH_PENDING: Generation triggered for ${proposal.title}. Project: $targetProjectId';
  }
}

final stitchBridgeServiceProvider = Provider((ref) => StitchBridgeService(ref));

