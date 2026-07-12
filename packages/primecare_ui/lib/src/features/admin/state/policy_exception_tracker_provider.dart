import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Policy Exception Tracker
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PolicyExceptionTrackerNotifier extends StateNotifier<AsyncValue<void>> {
  PolicyExceptionTrackerNotifier() : super(const AsyncValue.data(null));
}
