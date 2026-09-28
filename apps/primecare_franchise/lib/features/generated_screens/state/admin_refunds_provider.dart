// Governance - Category: state | Purpose: Riverpod state notifier for Admin Refunds
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AdminRefundsNotifier extends StateNotifier<AsyncValue<void>> {
  AdminRefundsNotifier() : super(const AsyncValue.data(null));
}
