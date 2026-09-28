// Governance - Category: state | Purpose: Riverpod state notifier for Operations Manager Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OperationsManagerReportsNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerReportsNotifier() : super(const AsyncValue.data(null));
}
