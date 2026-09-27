import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for GuestAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  GuestAnalyticsNotifier() : super(const AsyncValue.data(null));
}
