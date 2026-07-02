// Governance - Category: state | Purpose: Riverpod state notifier for Regional Bdm Deal Tracker
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmDealTrackerNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalBdmDealTrackerNotifier() : super(const AsyncValue.data(null));
}
