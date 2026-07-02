// Governance - Category: state | Purpose: Riverpod state notifier for Registry Entry Editor
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegistryEntryEditorNotifier extends StateNotifier<AsyncValue<void>> {
  RegistryEntryEditorNotifier() : super(const AsyncValue.data(null));
}
