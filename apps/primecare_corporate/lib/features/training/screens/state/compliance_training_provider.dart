// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Training
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceTrainingNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceTrainingNotifier() : super(const AsyncValue.data(null));
}
