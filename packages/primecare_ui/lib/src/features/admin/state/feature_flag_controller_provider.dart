import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Feature Flag Controller
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeatureFlagControllerNotifier extends StateNotifier<AsyncValue<void>> {
  FeatureFlagControllerNotifier() : super(const AsyncValue.data(null));
}
