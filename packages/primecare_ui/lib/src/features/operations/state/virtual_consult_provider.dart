import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Virtual Consult
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VirtualConsultNotifier extends StateNotifier<AsyncValue<void>> {
  VirtualConsultNotifier() : super(const AsyncValue.data(null));
}
