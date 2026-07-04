// Governance - Category: state | Purpose: Riverpod state notifier for FinanceDirectorComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceDirectorComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  FinanceDirectorComplianceNotifier() : super(const AsyncValue.data(null));
}
