import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Tenant Configuration
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TenantConfigurationNotifier extends StateNotifier<AsyncValue<void>> {
  TenantConfigurationNotifier() : super(const AsyncValue.data(null));
}
