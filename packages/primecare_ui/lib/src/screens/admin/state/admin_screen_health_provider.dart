import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for AdminScreenHealthScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminScreenHealthNotifier extends StateNotifier<AsyncValue<void>> {
  AdminScreenHealthNotifier() : super(const AsyncValue.data(null));
}
