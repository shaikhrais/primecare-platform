// Governance - Category: state | Purpose: Riverpod state notifier for Clinical Director Staffing
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalDirectorStaffingNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalDirectorStaffingNotifier() : super(const AsyncValue.data(null));
}
