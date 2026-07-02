// Governance - Category: state | Purpose: Riverpod state notifier for Visit Notes
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswVisitNotesNotifier extends StateNotifier<AsyncValue<void>> {
  PswVisitNotesNotifier() : super(const AsyncValue.data(null));
}
