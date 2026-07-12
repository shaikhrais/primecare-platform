import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Reset Password
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordNotifier extends StateNotifier<AsyncValue<void>> {
  ResetPasswordNotifier() : super(const AsyncValue.data(null));
}
