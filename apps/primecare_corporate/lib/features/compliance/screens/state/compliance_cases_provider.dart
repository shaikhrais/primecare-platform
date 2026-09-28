// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Cases
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class ComplianceCasesNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceCasesNotifier() : super(const AsyncValue.data(null));
}
