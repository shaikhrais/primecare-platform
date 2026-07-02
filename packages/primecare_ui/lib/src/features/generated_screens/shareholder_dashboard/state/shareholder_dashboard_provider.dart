// Governance - Category: state | Purpose: Riverpod state notifier for ShareholderDashboardScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShareholderDashboardNotifier extends StateNotifier<AsyncValue<void>> {
  ShareholderDashboardNotifier() : super(const AsyncValue.data(null));
}
