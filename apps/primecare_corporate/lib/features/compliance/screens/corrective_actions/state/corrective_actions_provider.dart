// Governance - Category: state | Purpose: Riverpod state notifier for Corrective Actions
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorrectiveActionsNotifier extends StateNotifier<AsyncValue<void>> {
  CorrectiveActionsNotifier() : super(const AsyncValue.data(null));
}
