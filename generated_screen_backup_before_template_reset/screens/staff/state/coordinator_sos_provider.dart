// Governance - Category: state | Purpose: Riverpod state notifier for CoordinatorSosScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoordinatorSosNotifier extends StateNotifier<AsyncValue<void>> {
  CoordinatorSosNotifier() : super(const AsyncValue.data(null));
}
