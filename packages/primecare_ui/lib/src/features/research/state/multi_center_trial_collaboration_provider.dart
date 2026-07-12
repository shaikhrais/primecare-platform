import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Multi Center Trial Collaboration
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MultiCenterTrialCollaborationNotifier extends StateNotifier<AsyncValue<void>> {
  MultiCenterTrialCollaborationNotifier() : super(const AsyncValue.data(null));
}
