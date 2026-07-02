// Governance - Category: state | Purpose: Riverpod state notifier for School Health Program Dashboard
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolHealthProgramDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  SchoolHealthProgramDashboardNotifier() : super(const AsyncValue.data(null));
}
