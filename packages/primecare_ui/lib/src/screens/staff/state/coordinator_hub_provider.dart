import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CoordinatorHubScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CoordinatorHubNotifier extends StateNotifier<AsyncValue<void>> {
  CoordinatorHubNotifier() : super(const AsyncValue.data(null));
}
