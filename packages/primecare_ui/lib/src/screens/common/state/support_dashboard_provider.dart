import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for SupportDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupportDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  SupportDashboardNotifier() : super(const AsyncValue.data(null));
}
