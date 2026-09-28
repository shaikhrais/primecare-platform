// Governance - Category: state | Purpose: Riverpod state notifier for Training Coordinator Certifications
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TrainingCoordinatorCertificationsNotifier extends StateNotifier<AsyncValue<void>> {
  TrainingCoordinatorCertificationsNotifier() : super(const AsyncValue.data(null));
}
