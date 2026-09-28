// Governance - Category: state | Purpose: Riverpod state notifier for Quality Assurance Reports
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class QualityAssuranceReportsNotifier extends StateNotifier<AsyncValue<void>> {
  QualityAssuranceReportsNotifier() : super(const AsyncValue.data(null));
}
