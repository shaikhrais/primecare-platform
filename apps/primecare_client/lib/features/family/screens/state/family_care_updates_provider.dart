// Governance - Category: state | Purpose: Riverpod state notifier for Family Care Updates
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyCareUpdatesNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyCareUpdatesNotifier() : super(const AsyncValue.data(null));
}
