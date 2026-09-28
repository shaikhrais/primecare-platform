// Governance - Category: state | Purpose: Riverpod state notifier for Coo Issue Escalations
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CooIssueEscalationsNotifier extends StateNotifier<AsyncValue<void>> {
  CooIssueEscalationsNotifier() : super(const AsyncValue.data(null));
}
