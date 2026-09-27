import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for C M E Tracking Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CMETrackingDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  CMETrackingDashboardNotifier() : super(const AsyncValue.data(null));
}
