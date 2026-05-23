// Governance - Category: model | Purpose: The architectural counterpart to [PrimeCareScreen]. This class represents a governed API service or endpoint within t...
import 'api_metadata.dart';

/// The architectural counterpart to [PrimeCareScreen].
/// This class represents a governed API service or endpoint within the platform.
abstract class PrimeCareApi {
  /// The identity and governance metadata for this API.
  /// Used by the [ApiGovernanceRegistry] to validate parity.
  ApiMetadata get metadata;

  /// The unique identifier for this API, matching the registry ID.
  String get id => metadata.id;

  /// Validates the request against the governance [SecurityTier] and [AuditStatus].
  bool get isExecutionAllowed => metadata.isAuditCompliant;
  
  /// The design standard that this API supports (e.g., 4K payloads).
  Object? get designStandard => metadata.designSize;
}

/// A specialized implementation for RESTful/Shelf-based APIs.
abstract class GovernedRestApi extends PrimeCareApi {
  /// The actual logic for the endpoint.
  /// This is where the "already existing code" is integrated.
  Future<Object> handleRequest(Object request);
}
