import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for IntakeCoordinatorReferralsScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorReferralsNotifier extends StateNotifier<AsyncValue<void>> {
  IntakeCoordinatorReferralsNotifier() : super(const AsyncValue.data(null));
}
