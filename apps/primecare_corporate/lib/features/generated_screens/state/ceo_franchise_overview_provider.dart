// Governance - Category: state | Purpose: Riverpod state notifier for Ceo Franchise Overview
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CeoFranchiseOverviewNotifier extends StateNotifier<AsyncValue<void>> {
  CeoFranchiseOverviewNotifier() : super(const AsyncValue.data(null));
}
