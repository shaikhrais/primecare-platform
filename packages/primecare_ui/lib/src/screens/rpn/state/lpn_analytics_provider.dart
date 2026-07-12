import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Licensed Practical Nurse (LPN) Analytics
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LpnAnalyticsNotifier extends StateNotifier<AsyncValue<void>> {
  LpnAnalyticsNotifier() : super(const AsyncValue.data(null));
}
