// Governance - Category: state | Purpose: Riverpod state notifier for Digital Symptom Checker
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DigitalSymptomCheckerNotifier extends StateNotifier<AsyncValue<void>> {
  DigitalSymptomCheckerNotifier() : super(const AsyncValue.data(null));
}
