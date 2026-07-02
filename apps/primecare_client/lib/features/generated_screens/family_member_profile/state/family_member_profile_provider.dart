// Governance - Category: state | Purpose: Riverpod state notifier for Family Member Profile
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberProfileNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyMemberProfileNotifier() : super(const AsyncValue.data(null));
}
