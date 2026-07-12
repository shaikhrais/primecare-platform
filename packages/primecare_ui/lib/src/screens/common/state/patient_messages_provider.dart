import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for PatientMessagesScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PatientMessagesNotifier extends StateNotifier<AsyncValue<void>> {
  PatientMessagesNotifier() : super(const AsyncValue.data(null));
}
