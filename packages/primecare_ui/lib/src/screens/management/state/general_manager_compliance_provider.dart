import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for GeneralManagerComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeneralManagerComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  GeneralManagerComplianceNotifier() : super(const AsyncValue.data(null));
}
