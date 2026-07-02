// Governance - Category: state | Purpose: Riverpod state notifier for CtoDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CtoDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CtoDashboardNotifier() : super(const AsyncValue.data(null));
}
