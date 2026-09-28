// Governance - Category: state | Purpose: Riverpod state notifier for Security Sentinel
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SecuritySentinelNotifier extends StateNotifier<AsyncValue<void>> {
  SecuritySentinelNotifier() : super(const AsyncValue.data(null));
}
