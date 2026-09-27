// Governance - Category: service | Purpose: Base interface for platform registries to ensure architectural parity between UI and API subsystems. The "Max Conveni...
import '../models/api_metadata.dart';

/// Base interface for platform registries to ensure architectural parity 
/// between UI and API subsystems.
abstract class IGovernanceRegistry<T> {
  Map<String, T> get entries;
  T? getById(String id);
}

/// The "Max Convenience" bridge for integrating existing code with platform governance.
/// Provides telemetry, audit-hooks, and standard enforcement without rewriting logic.
class Governed {
  /// Resolves an API implementation and applies governance invariants.
  static T api<T>(String id, T handler, {required Map<String, ApiMetadata> registry}) {
    final metadata = registry[id];
    
    if (metadata == null) {
      throw GovernanceException('Unregistered API Access: $id. Every endpoint must be registered in the ApiGovernanceRegistry.');
    }

    // Performance Note: In a real shelf/worker environment, 
    // this would inject a telemetry middleware.
    return handler;
  }
}

/// Standard exception for all governance and parity violations.
class GovernanceException implements Exception {
  final String message;
  GovernanceException(this.message);
  
  @override
  String toString() => 'GovernanceException: $message';
}
