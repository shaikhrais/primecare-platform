import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ClinicComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicComplianceNotifier() : super(const AsyncValue.data(null));
}
