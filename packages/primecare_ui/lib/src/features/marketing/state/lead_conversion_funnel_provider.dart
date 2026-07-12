import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Lead Conversion Funnel
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeadConversionFunnelNotifier extends StateNotifier<AsyncValue<void>> {
  LeadConversionFunnelNotifier() : super(const AsyncValue.data(null));
}
