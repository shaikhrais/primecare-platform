// Governance - Category: state | Purpose: Riverpod state notifier for FranchiseComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseComplianceNotifier() : super(const AsyncValue.data(null));
}
