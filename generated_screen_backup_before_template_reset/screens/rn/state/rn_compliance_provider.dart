// Governance - Category: state | Purpose: Riverpod state notifier for RnComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RnComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  RnComplianceNotifier() : super(const AsyncValue.data(null));
}
