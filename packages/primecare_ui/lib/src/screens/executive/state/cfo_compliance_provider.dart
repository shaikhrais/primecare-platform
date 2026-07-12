import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CfoComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  CfoComplianceNotifier() : super(const AsyncValue.data(null));
}
