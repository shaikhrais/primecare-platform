// Governance - Category: state | Purpose: Riverpod state notifier for RegionalBdmComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalBdmComplianceNotifier() : super(const AsyncValue.data(null));
}
