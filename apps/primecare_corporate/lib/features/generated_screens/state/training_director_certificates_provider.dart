// Governance - Category: state | Purpose: Riverpod state notifier for Training Director Certificates
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrainingDirectorCertificatesNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingDirectorCertificatesNotifier() : super(const AsyncValue.data(null));
}
