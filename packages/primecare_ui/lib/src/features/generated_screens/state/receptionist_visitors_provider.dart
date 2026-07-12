import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Receptionist Visitors
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceptionistVisitorsNotifier extends StateNotifier<AsyncValue<void>> {
  ReceptionistVisitorsNotifier() : super(const AsyncValue.data(null));
}
