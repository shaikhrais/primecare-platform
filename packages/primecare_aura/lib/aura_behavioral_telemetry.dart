// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Tracks user behavioral interactions with Aura insights and suggestions. This data is used to...
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_models/primecare_models.dart';
import 'package:primecare_execution_gate/primecare_execution_gate.dart';
import 'package:primecare_platform_domain/primecare_platform_domain.dart';

part 'src/application/services/aura_behavioral_telemetry.dart';


final auraBehavioralTelemetryProvider = Provider<AuraBehavioralTelemetry>((
  ref,
) {
  return AuraBehavioralTelemetry(ref);
});
