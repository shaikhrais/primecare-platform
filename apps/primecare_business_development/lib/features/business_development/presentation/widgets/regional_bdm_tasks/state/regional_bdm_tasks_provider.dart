// Governance - Category: state | Purpose: Riverpod state notifier for Regional Bdm Tasks
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegionalBdmTasksNotifier extends StateNotifier<AsyncValue<void>> {
  RegionalBdmTasksNotifier() : super(const AsyncValue.data(null));
}
