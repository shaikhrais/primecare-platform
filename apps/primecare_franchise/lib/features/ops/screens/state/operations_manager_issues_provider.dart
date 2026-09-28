// Governance - Category: state | Purpose: Riverpod state notifier for Operations Manager Issues
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OperationsManagerIssuesNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerIssuesNotifier() : super(const AsyncValue.data(null));
}
