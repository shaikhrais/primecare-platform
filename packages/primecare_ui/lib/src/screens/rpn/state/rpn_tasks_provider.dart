import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RpnTasksScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RpnTasksNotifier extends StateNotifier<AsyncValue<void>> {
  RpnTasksNotifier() : super(const AsyncValue.data(null));
}
