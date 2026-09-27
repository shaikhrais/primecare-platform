import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CaregiverTasksScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverTasksNotifier extends StateNotifier<AsyncValue<void>> {
  CaregiverTasksNotifier() : super(const AsyncValue.data(null));
}
