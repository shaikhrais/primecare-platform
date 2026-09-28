// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Manager Compliance Cases
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ComplianceManagerComplianceCasesNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceManagerComplianceCasesNotifier() : super(const AsyncValue.data(null));
}
