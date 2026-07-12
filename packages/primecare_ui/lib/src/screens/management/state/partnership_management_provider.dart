import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for PartnershipManagementScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PartnershipManagementNotifier extends StateNotifier<AsyncValue<void>> {
  PartnershipManagementNotifier() : super(const AsyncValue.data(null));
}
