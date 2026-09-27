import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Sso Redirect
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SsoRedirectNotifier extends StateNotifier<AsyncValue<void>> {
  SsoRedirectNotifier() : super(const AsyncValue.data(null));
}
