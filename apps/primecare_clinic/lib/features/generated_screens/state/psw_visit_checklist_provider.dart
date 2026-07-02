// Governance - Category: state | Purpose: Riverpod state notifier for Psw Visit Checklist
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswVisitChecklistNotifier extends StateNotifier<AsyncValue<void>> {
  PswVisitChecklistNotifier() : super(const AsyncValue.data(null));
}
