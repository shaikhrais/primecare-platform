// Governance - Category: state | Purpose: Riverpod state notifier for Family Emergency Contacts
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyEmergencyContactsNotifier extends StateNotifier<AsyncValue<void>> {
  FamilyEmergencyContactsNotifier() : super(const AsyncValue.data(null));
}
