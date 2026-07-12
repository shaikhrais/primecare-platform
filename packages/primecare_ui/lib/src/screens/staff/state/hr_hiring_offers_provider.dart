import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for HrHiringOffersScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrHiringOffersNotifier extends StateNotifier<AsyncValue<void>> {
  HrHiringOffersNotifier() : super(const AsyncValue.data(null));
}
