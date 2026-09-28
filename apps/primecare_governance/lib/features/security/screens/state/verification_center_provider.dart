// Governance - Category: state | Purpose: Riverpod state notifier for Verification Center
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class VerificationCenterNotifier extends StateNotifier<AsyncValue<void>> {
  VerificationCenterNotifier() : super(const AsyncValue.data(null));
}
