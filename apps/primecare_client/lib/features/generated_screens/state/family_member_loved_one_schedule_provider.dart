// Governance - Category: state | Purpose: Riverpod state notifier for Family Member Loved One Schedule
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FamilyMemberLovedOneScheduleNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyMemberLovedOneScheduleNotifier() : super(const AsyncValue.data(null));
}
