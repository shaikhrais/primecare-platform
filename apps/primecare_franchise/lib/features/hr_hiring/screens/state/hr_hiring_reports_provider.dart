// Governance - Category: state | Purpose: Riverpod state notifier for Hr Hiring Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HrHiringReportsNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringReportsNotifier() : super(const AsyncValue.data(null));
}
