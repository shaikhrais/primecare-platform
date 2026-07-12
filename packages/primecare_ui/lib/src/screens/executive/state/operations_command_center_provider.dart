import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for OperationsCommandCenterScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperationsCommandCenterNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsCommandCenterNotifier() : super(const AsyncValue.data(null));
}
