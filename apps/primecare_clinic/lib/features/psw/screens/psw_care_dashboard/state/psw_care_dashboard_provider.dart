// Governance - Category: state | Purpose: Riverpod state notifier for Psw Care Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswCareDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  PswCareDashboardNotifier() : super(const AsyncValue.data(null));
}
