import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for PortalComplianceScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PortalComplianceNotifier extends StateNotifier<AsyncValue<void>> {
  PortalComplianceNotifier() : super(const AsyncValue.data(null));
}
