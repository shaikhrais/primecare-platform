// Governance - Category: state | Purpose: Riverpod state notifier for Certificates
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CertificatesNotifier extends StateNotifier<AsyncValue<void>> {
  CertificatesNotifier() : super(const AsyncValue.data(null));
}
