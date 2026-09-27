import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for FamilyMemberWorkflowScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyMemberWorkflowNotifier() : super(const AsyncValue.data(null));
}
