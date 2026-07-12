import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ChiropractorComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropractorComplianceNotifier() : super(const AsyncValue.data(null));
}
