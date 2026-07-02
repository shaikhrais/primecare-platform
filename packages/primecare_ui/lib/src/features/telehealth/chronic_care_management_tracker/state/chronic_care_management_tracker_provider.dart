// Governance - Category: state | Purpose: Riverpod state notifier for Chronic Care Management Tracker
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChronicCareManagementTrackerNotifier extends StateNotifier<AsyncValue<void>> {
  ChronicCareManagementTrackerNotifier() : super(const AsyncValue.data(null));
}
