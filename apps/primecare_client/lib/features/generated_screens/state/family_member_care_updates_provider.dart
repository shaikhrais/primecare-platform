// Governance - Category: state | Purpose: Riverpod state notifier for Family Member Care Updates
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberCareUpdatesNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyMemberCareUpdatesNotifier() : super(const AsyncValue.data(null));
}
