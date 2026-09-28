// Governance - Category: state | Purpose: Riverpod state notifier for Client Payments
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ClientPaymentsNotifier extends StateNotifier<AsyncValue<void>> {
  ClientPaymentsNotifier() : super(const AsyncValue.data(null));
}
