// Governance - Category: state | Purpose: Riverpod state notifier for CertificationTrackingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CertificationTrackingNotifier extends StateNotifier<AsyncValue<void>> {
  CertificationTrackingNotifier() : super(const AsyncValue.data(null));
}
