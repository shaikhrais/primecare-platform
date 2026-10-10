// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Tracks user behavioral interactions with Aura insights and suggestions. This data is used to...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

part 'src/application/services/aura_behavioral_telemetry.dart';


final auraBehavioralTelemetryProvider = Provider<AuraBehavioralTelemetry>((
  ref,
) {
  return AuraBehavioralTelemetry(ref);
});
