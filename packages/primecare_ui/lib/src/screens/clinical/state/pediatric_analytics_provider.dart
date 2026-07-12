import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Pediatric Specialist Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PediatricAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  PediatricAnalyticsNotifier() : super(const AsyncValue.data(null));
}
