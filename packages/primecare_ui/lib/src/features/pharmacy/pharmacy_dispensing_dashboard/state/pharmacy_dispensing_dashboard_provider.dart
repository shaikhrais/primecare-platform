// Governance - Category: state | Purpose: Riverpod state notifier for Pharmacy Dispensing Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PharmacyDispensingDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  PharmacyDispensingDashboardNotifier() : super(const AsyncValue.data(null));
}
