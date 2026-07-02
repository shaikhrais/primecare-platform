// Governance - Category: state | Purpose: Riverpod state notifier for Certifications
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CertificationsNotifier extends StateNotifier<AsyncValue<void>> {
  CertificationsNotifier() : super(const AsyncValue.data(null));
}
