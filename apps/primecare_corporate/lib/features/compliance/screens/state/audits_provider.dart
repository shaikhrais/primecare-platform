// Governance - Category: state | Purpose: Riverpod state notifier for Audits
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuditsNotifier extends StateNotifier<AsyncValue<void>> {
  AuditsNotifier() : super(const AsyncValue.data(null));
}
