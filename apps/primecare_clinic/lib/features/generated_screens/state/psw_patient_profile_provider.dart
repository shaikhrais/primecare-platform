// Governance - Category: state | Purpose: Riverpod state notifier for Psw Patient Profile
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswPatientProfileNotifier extends StateNotifier<AsyncValue<void>> {
  PswPatientProfileNotifier() : super(const AsyncValue.data(null));
}
