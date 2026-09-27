// Governance - Category: state | Purpose: Riverpod state notifier for Family Loved One Schedule
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyLovedOneScheduleNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyLovedOneScheduleNotifier() : super(const AsyncValue.data(null));
}
