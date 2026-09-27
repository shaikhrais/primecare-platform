// Governance - Category: state | Purpose: Riverpod state notifier for OwnerComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnerComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  OwnerComplianceNotifier() : super(const AsyncValue.data(null));
}
