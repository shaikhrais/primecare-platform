import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CooOperationsOverviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooOperationsOverviewNotifier extends StateNotifier<AsyncValue<void>> {
  CooOperationsOverviewNotifier() : super(const AsyncValue.data(null));
}
