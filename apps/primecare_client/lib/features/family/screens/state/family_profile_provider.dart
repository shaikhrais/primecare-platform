// Governance - Category: state | Purpose: Riverpod state notifier for Family Profile
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FamilyProfileNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyProfileNotifier() : super(const AsyncValue.data(null));
}
