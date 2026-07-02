// Governance - Category: state | Purpose: Riverpod state notifier for Vendor Risk Assessor
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorRiskAssessorNotifier extends StateNotifier<AsyncValue<void>> {
  VendorRiskAssessorNotifier() : super(const AsyncValue.data(null));
}
