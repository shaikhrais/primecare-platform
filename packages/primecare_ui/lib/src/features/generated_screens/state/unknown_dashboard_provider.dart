import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Unknown Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnknownDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  UnknownDashboardNotifier() : super(const AsyncValue.data(null));
}
