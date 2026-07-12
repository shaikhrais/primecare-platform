import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for IntakeComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeComplianceNotifier() : super(const AsyncValue.data(null));
}
