import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for IntakeCoordinatorBookingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorBookingNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorBookingNotifier() : super(const AsyncValue.data(null));
}
