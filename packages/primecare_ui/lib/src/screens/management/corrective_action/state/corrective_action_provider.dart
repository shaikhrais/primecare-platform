// Governance - Category: state | Purpose: Riverpod state notifier for CorrectiveActionScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CorrectiveActionNotifier extends StateNotifier<AsyncValue<void>> {
  CorrectiveActionNotifier() : super(const AsyncValue.data(null));
}
