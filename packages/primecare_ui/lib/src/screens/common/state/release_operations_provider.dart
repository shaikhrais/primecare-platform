import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ReleaseOperationsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReleaseOperationsNotifier extends StateNotifier<AsyncValue<void>> {
  ReleaseOperationsNotifier() : super(const AsyncValue.data(null));
}
