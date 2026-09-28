// Governance - Category: state | Purpose: Riverpod state notifier for Franchise Sales Manager Prospects
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FranchiseSalesManagerProspectsNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseSalesManagerProspectsNotifier() : super(const AsyncValue.data(null));
}
