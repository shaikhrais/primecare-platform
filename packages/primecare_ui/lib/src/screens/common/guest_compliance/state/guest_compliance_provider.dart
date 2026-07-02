// Governance - Category: state | Purpose: Riverpod state notifier for GuestComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  GuestComplianceNotifier() : super(const AsyncValue.data(null));
}
