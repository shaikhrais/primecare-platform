import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Governed
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GovernedNotifier extends StateNotifier<AsyncValue<void>> {
  GovernedNotifier() : super(const AsyncValue.data(null));
}
