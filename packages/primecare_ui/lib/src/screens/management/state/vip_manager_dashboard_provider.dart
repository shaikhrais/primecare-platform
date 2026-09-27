import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for VipManagerDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VipManagerDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  VipManagerDashboardNotifier() : super(const AsyncValue.data(null));
}
