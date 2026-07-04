// Governance - Category: state | Purpose: Riverpod state notifier for Vitals Entry
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VitalsEntryNotifier extends StateNotifier<AsyncValue<void>> {
  VitalsEntryNotifier() : super(const AsyncValue.data(null));
}
