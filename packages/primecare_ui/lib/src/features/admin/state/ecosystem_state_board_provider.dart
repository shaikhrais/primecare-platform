// Governance - Category: state | Purpose: Riverpod state notifier for Ecosystem State Board
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EcosystemStateBoardNotifier extends StateNotifier<AsyncValue<void>> {
  EcosystemStateBoardNotifier() : super(const AsyncValue.data(null));
}
