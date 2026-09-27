import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CxDirectorDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CxDirectorDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CxDirectorDashboardNotifier() : super(const AsyncValue.data(null));
}
