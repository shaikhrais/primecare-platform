import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for OfficeComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfficeComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  OfficeComplianceNotifier() : super(const AsyncValue.data(null));
}
