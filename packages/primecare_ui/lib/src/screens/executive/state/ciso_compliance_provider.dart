import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CisoComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CisoComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  CisoComplianceNotifier() : super(const AsyncValue.data(null));
}
