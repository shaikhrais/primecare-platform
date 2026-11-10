import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernanceActionResponse {
  final bool success;
  final String output;
  final String? error;
  GovernanceActionResponse({required this.success, required this.output, this.error});
}

/// No production transport has been registered for this legacy adapter.
/// Provider overrides may supply an authorized implementation; missing transport
/// must never produce synthetic metrics, security events or command receipts.
class GovernanceApiService {
  Future<Map<String, dynamic>> fetchLiveTelemetry() async =>
      throw UnsupportedError('Governance telemetry transport is not configured.');

  Stream<Map<String, dynamic>> get telemetryStream => Stream.error(
    UnsupportedError('Governance telemetry transport is not configured.'));

  Future<GovernanceActionResponse> executeAction(String command) async =>
      GovernanceActionResponse(success: false,
        output: 'Governance action transport is not configured.',
        error: 'GOVERNANCE_ACTION_TRANSPORT_NOT_CONFIGURED');
}

final governanceApiServiceProvider = Provider((ref) => GovernanceApiService());
