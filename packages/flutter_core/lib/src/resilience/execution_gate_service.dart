// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Level of impact for an institutional insight or anomaly. Types of events that the Aura Pulse...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Level of impact for an institutional insight or anomaly.
export 'package:primecare_models/src/models/insight_impact.dart';

export 'package:primecare_models/src/models/aura_event.dart';
export 'package:primecare_models/src/models/aura_event_type.dart';
export 'package:primecare_models/src/models/execution_gate_category.dart';
import 'package:primecare_models/src/models/execution_gate_category.dart';
part '../infrastructure/telemetry/execution_gate_service.dart';



/// Global provider for the ExecutionGateService.
final executionGateProvider = Provider<ExecutionGateService>((ref) {
  return ExecutionGateService();
});
