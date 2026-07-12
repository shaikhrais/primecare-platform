import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for RmtComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RmtComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  RmtComplianceNotifier() : super(const AsyncValue.data(null));
}
