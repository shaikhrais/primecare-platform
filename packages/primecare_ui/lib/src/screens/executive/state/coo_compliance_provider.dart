import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CooComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  CooComplianceNotifier() : super(const AsyncValue.data(null));
}
