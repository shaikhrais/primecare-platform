// Governance - Category: state | Purpose: Riverpod state notifier for ComplianceOverviewScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplianceOverviewNotifier extends StateNotifier<AsyncValue<void>> {
  ComplianceOverviewNotifier() : super(const AsyncValue.data(null));
}
