import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RefundManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RefundManagementNotifier extends StateNotifier<AsyncValue<void>> {
  RefundManagementNotifier() : super(const AsyncValue.data(null));
}
