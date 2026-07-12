import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Telemedicine Prescription Pad
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TelemedicinePrescriptionPadNotifier extends StateNotifier<AsyncValue<void>> {
  TelemedicinePrescriptionPadNotifier() : super(const AsyncValue.data(null));
}
