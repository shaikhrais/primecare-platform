// Governance - Category: state | Purpose: Riverpod state notifier for QaComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QaComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  QaComplianceNotifier() : super(const AsyncValue.data(null));
}
