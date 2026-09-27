import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for IntakeAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeAnalyticsNotifier() : super(const AsyncValue.data(null));
}
