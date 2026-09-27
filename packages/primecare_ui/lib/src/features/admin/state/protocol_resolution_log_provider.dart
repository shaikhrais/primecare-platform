import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Protocol Resolution Log
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProtocolResolutionLogNotifier extends StateNotifier<AsyncValue<void>> {
  ProtocolResolutionLogNotifier() : super(const AsyncValue.data(null));
}
