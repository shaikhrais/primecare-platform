// Governance - Category: state | Purpose: Riverpod state notifier for Training Director Certifications
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDirectorCertificationsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingDirectorCertificationsNotifier() : super(const AsyncValue.data(null));
}
