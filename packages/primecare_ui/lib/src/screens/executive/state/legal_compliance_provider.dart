import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for LegalComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LegalComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  LegalComplianceNotifier() : super(const AsyncValue.data(null));
}
