import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Clinical Outcomes Report
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalOutcomesReportNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalOutcomesReportNotifier() : super(const AsyncValue.data(null));
}
