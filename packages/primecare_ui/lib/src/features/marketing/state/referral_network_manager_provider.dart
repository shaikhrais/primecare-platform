import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Referral Network Manager
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReferralNetworkManagerNotifier extends StateNotifier<AsyncValue<void>> {
  ReferralNetworkManagerNotifier() : super(const AsyncValue.data(null));
}
