// Governance - Category: state | Purpose: Riverpod state notifier for Forgot Password
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgotPasswordNotifier extends StateNotifier<AsyncValue<void>> {
  ForgotPasswordNotifier() : super(const AsyncValue.data(null));
}
