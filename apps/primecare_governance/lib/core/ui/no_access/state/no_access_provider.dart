// Governance - Category: state | Purpose: Riverpod state notifier for No Access
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoAccessNotifier extends StateNotifier<AsyncValue<void>> {
  NoAccessNotifier() : super(const AsyncValue.data(null));
}
