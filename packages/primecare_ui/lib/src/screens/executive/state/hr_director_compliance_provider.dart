import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HrDirectorComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  HrDirectorComplianceNotifier() : super(const AsyncValue.data(null));
}
