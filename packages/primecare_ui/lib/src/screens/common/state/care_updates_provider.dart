import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CareUpdatesScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CareUpdatesNotifier extends StateNotifier<AsyncValue<void>> {
  CareUpdatesNotifier() : super(const AsyncValue.data(null));
}
