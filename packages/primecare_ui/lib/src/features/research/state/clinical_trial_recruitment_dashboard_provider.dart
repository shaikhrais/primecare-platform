// Governance - Category: state | Purpose: Riverpod state notifier for Clinical Trial Recruitment Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalTrialRecruitmentDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalTrialRecruitmentDashboardNotifier() : super(const AsyncValue.data(null));
}
