// Governance - Category: state | Purpose: Riverpod state notifier for Training Compliance
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingComplianceNotifier() : super(const AsyncValue.data(null));
}
