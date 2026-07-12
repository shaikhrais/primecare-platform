import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Mobile Clinic Dispatch
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileClinicDispatchNotifier extends StateNotifier<AsyncValue<void>> {
  MobileClinicDispatchNotifier() : super(const AsyncValue.data(null));
}
