import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CooStaffingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CooStaffingNotifier extends StateNotifier<AsyncValue<void>> {
  CooStaffingNotifier() : super(const AsyncValue.data(null));
}
