import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Chemotherapy Protocol Builder
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChemotherapyProtocolBuilderNotifier extends StateNotifier<AsyncValue<void>> {
  ChemotherapyProtocolBuilderNotifier() : super(const AsyncValue.data(null));
}
