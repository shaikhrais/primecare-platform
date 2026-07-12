import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for CommunicationScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunicationNotifier extends StateNotifier<AsyncValue<void>> {
  CommunicationNotifier() : super(const AsyncValue.data(null));
}
