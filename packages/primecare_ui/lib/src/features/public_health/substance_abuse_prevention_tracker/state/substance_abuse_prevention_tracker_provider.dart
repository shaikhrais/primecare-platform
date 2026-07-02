// Governance - Category: state | Purpose: Riverpod state notifier for Substance Abuse Prevention Tracker
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubstanceAbusePreventionTrackerNotifier extends StateNotifier<AsyncValue<void>> {
  SubstanceAbusePreventionTrackerNotifier() : super(const AsyncValue.data(null));
}
