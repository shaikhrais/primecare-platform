// Governance - Category: state | Purpose: Riverpod state notifier for ApplicantTrackingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApplicantTrackingNotifier extends StateNotifier<AsyncValue<void>> {
  ApplicantTrackingNotifier() : super(const AsyncValue.data(null));
}
