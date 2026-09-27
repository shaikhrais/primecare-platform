import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for PhysiotherapistAppointmentsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhysiotherapistAppointmentsNotifier extends StateNotifier<AsyncValue<void>> {
  PhysiotherapistAppointmentsNotifier() : super(const AsyncValue.data(null));
}
