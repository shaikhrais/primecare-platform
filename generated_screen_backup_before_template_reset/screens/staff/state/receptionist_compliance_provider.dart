// Governance - Category: state | Purpose: Riverpod state notifier for ReceptionistComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  ReceptionistComplianceNotifier() : super(const AsyncValue.data(null));
}
