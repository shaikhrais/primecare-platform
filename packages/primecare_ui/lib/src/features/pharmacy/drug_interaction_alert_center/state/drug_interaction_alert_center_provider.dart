// Governance - Category: state | Purpose: Riverpod state notifier for Drug Interaction Alert Center
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DrugInteractionAlertCenterNotifier extends StateNotifier<AsyncValue<void>> {
  DrugInteractionAlertCenterNotifier() : super(const AsyncValue.data(null));
}
