// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Manager Policies
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ComplianceManagerPoliciesNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceManagerPoliciesNotifier() : super(const AsyncValue.data(null));
}
