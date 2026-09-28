// Governance - Category: state | Purpose: Riverpod state notifier for Franchise Owner Hiring
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FranchiseOwnerHiringNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseOwnerHiringNotifier() : super(const AsyncValue.data(null));
}
