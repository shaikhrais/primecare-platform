// Governance - Category: state | Purpose: Riverpod state notifier for ClinicalComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClinicalComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  ClinicalComplianceNotifier() : super(const AsyncValue.data(null));
}
