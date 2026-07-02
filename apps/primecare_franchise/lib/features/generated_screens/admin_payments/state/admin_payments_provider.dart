// Governance - Category: state | Purpose: Riverpod state notifier for Admin Payments
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminPaymentsNotifier extends StateNotifier<AsyncValue<void>> {
  AdminPaymentsNotifier() : super(const AsyncValue.data(null));
}
