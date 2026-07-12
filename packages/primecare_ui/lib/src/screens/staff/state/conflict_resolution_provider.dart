import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ConflictResolutionScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConflictResolutionNotifier extends StateNotifier<AsyncValue<void>> {
  ConflictResolutionNotifier() : super(const AsyncValue.data(null));
}
