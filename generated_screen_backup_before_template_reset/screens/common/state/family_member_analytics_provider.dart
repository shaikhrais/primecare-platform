// Governance - Category: state | Purpose: Riverpod state notifier for FamilyMemberAnalyticsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyMemberAnalyticsNotifier() : super(const AsyncValue.data(null));
}
