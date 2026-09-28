// Governance - Category: state | Purpose: Riverpod state notifier for Operations Manager Daily Operations
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OperationsManagerDailyOperationsNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerDailyOperationsNotifier() : super(const AsyncValue.data(null));
}
