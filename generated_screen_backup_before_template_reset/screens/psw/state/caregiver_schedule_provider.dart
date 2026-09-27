// Governance - Category: state | Purpose: Riverpod state notifier for CaregiverScheduleScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverScheduleNotifier extends StateNotifier<AsyncValue<void>> {
  CaregiverScheduleNotifier() : super(const AsyncValue.data(null));
}
