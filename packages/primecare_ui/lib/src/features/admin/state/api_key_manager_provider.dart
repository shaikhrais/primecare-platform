// Governance - Category: state | Purpose: Riverpod state notifier for Api Key Manager
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiKeyManagerNotifier extends StateNotifier<AsyncValue<void>> {
  ApiKeyManagerNotifier() : super(const AsyncValue.data(null));
}
