// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE as ComponentWarehouse is in primecare_ui which depends on flutter_core. A centralized utilit...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/foundation.dart';
import '../../registry/governance_registry.dart';
// Note: We don't import ComponentWarehouse here to avoid circular dependencies
// as ComponentWarehouse is in primecare_ui which depends on flutter_core.

/// A centralized utility for performing "Mechanical Repairs" on the platform state.
/// This is used during the Self-Healing Loop to clear corrupted registries and caches.
class MechanicalRepairKit {
  /// Performs a deep flush of all platform-level registries and caches.
  ///
  /// [onCustomFlush] allows apps to provide their own cleanup logic (e.g. clearing primecare_ui warehouses).
  static void performDeepFlush({VoidCallback? onCustomFlush}) {
    debugPrint(
      'PRIMECARE_REPAIR: 🧼 Initiating Deep Flush of platform registries...',
    );

    // 1. Flush Governance Intents
    GovernanceRegistry.flush();

    // 2. Clear any custom app-level state
    if (onCustomFlush != null) {
      onCustomFlush();
    }

    debugPrint(
      'PRIMECARE_REPAIR: ✅ Deep Flush complete. Ready for re-bootstrap.',
    );
  }
}
