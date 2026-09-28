// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Manager Training Compliance
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ComplianceManagerTrainingComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceManagerTrainingComplianceNotifier() : super(const AsyncValue.data(null));
}
