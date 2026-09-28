// Governance - Category: state | Purpose: Riverpod state notifier for Ceo Approvals
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CeoApprovalsNotifier extends StateNotifier<AsyncValue<void>> {
  CeoApprovalsNotifier() : super(const AsyncValue.data(null));
}
