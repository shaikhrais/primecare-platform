import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for VitalsTrackingScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VitalsTrackingNotifier extends StateNotifier<AsyncValue<void>> {
  VitalsTrackingNotifier() : super(const AsyncValue.data(null));
}
