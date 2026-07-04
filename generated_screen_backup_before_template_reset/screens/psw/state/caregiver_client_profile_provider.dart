// Governance - Category: state | Purpose: Riverpod state notifier for CaregiverClientProfileScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverClientProfileNotifier extends StateNotifier<AsyncValue<void>> {
  CaregiverClientProfileNotifier() : super(const AsyncValue.data(null));
}
