import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ChiropractorAppointmentsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorAppointmentsNotifier extends StateNotifier<AsyncValue<void>> {
  ChiropractorAppointmentsNotifier() : super(const AsyncValue.data(null));
}
