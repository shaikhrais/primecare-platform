import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for OfficeDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfficeDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  OfficeDashboardNotifier() : super(const AsyncValue.data(null));
}
