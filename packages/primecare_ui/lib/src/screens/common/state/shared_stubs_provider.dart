import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for SharedScreenStubs
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SharedStubsNotifier extends StateNotifier<AsyncValue<void>> {
  SharedStubsNotifier() : super(const AsyncValue.data(null));
}
