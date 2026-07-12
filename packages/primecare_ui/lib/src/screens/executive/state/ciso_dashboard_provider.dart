import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CisoDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CisoDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CisoDashboardNotifier() : super(const AsyncValue.data(null));
}
