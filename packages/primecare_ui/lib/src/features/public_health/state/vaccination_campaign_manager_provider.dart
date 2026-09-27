import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Vaccination Campaign Manager
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VaccinationCampaignManagerNotifier extends StateNotifier<AsyncValue<void>> {
  VaccinationCampaignManagerNotifier() : super(const AsyncValue.data(null));
}
