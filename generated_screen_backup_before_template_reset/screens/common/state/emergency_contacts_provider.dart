// Governance - Category: state | Purpose: Riverpod state notifier for EmergencyContactsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencyContactsNotifier extends StateNotifier<AsyncValue<void>> {
  EmergencyContactsNotifier() : super(const AsyncValue.data(null));
}
