// Governance - Category: state | Purpose: Riverpod state notifier for Client Care Team
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientCareTeamNotifier extends StateNotifier<AsyncValue<void>> {
  ClientCareTeamNotifier() : super(const AsyncValue.data(null));
}
