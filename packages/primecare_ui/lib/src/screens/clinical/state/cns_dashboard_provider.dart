import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CnsDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CnsDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CnsDashboardNotifier() : super(const AsyncValue.data(null));
}
