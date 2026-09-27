import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HrManagerComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrManagerComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  HrManagerComplianceNotifier() : super(const AsyncValue.data(null));
}
