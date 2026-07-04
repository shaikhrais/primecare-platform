// Governance - Category: state | Purpose: Riverpod state notifier for Psw Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  PswAnalyticsNotifier() : super(const AsyncValue.data(null));
}
