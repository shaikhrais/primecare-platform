import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for FamilyMemberComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyMemberComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyMemberComplianceNotifier() : super(const AsyncValue.data(null));
}
