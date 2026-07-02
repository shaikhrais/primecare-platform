// Governance - Category: state | Purpose: Riverpod state notifier for Resource Allocation Map
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResourceAllocationMapNotifier extends StateNotifier<AsyncValue<void>> {
  ResourceAllocationMapNotifier() : super(const AsyncValue.data(null));
}
