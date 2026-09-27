// Governance - Category: state | Purpose: Riverpod state notifier for HrHiringInterviewsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringInterviewsNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringInterviewsNotifier() : super(const AsyncValue.data(null));
}
