// Governance - Category: state | Purpose: Riverpod state notifier for Research Protocol Manager
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResearchProtocolManagerNotifier extends StateNotifier<AsyncValue<void>> {
  ResearchProtocolManagerNotifier() : super(const AsyncValue.data(null));
}
