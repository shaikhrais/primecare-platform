// Governance - Category: state | Purpose: Riverpod state notifier for Help Desk Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HelpDeskDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  HelpDeskDashboardNotifier() : super(const AsyncValue.data(null));
}
