import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Virtual Waiting Room
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VirtualWaitingRoomNotifier extends StateNotifier<AsyncValue<void>> {
  VirtualWaitingRoomNotifier() : super(const AsyncValue.data(null));
}
