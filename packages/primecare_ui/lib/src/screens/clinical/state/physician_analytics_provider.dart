import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Physician Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysicianAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  PhysicianAnalyticsNotifier() : super(const AsyncValue.data(null));
}
