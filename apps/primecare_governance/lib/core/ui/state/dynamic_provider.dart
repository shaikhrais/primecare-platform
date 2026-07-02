// Governance - Category: state | Purpose: Riverpod state notifier for Dynamic
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicNotifier extends StateNotifier<AsyncValue<void>> {
  DynamicNotifier() : super(const AsyncValue.data(null));
}
