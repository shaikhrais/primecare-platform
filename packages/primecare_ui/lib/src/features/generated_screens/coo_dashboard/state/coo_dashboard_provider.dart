// Governance - Category: state | Purpose: Riverpod state notifier for CooDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CooDashboardNotifier() : super(const AsyncValue.data(null));
}
