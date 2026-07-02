// Governance - Category: state | Purpose: Riverpod state notifier for Compliance Manager Corrective Actions
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceManagerCorrectiveActionsNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceManagerCorrectiveActionsNotifier() : super(const AsyncValue.data(null));
}
