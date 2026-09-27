import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ReferralManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReferralManagementNotifier extends StateNotifier<AsyncValue<void>> {
  ReferralManagementNotifier() : super(const AsyncValue.data(null));
}
