import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Biospecimen Inventory Tracker
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BiospecimenInventoryTrackerNotifier extends StateNotifier<AsyncValue<void>> {
  BiospecimenInventoryTrackerNotifier() : super(const AsyncValue.data(null));
}
