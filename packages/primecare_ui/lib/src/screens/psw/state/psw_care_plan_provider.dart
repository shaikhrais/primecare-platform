import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Psw Care Plan
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswCarePlanNotifier extends StateNotifier<AsyncValue<void>> {
  PswCarePlanNotifier() : super(const AsyncValue.data(null));
}
