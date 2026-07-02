// Governance - Category: state | Purpose: Riverpod state notifier for Franchise Sales Manager Compliance Workflow
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FranchiseSalesWorkflowNotifier extends StateNotifier<AsyncValue<void>> {
  FranchiseSalesWorkflowNotifier() : super(const AsyncValue.data(null));
}
