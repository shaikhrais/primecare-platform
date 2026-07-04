// Governance - Category: state | Purpose: Riverpod state notifier for HrHiringComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringComplianceNotifier() : super(const AsyncValue.data(null));
}
