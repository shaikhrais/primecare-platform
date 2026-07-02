// Governance - Category: state | Purpose: Riverpod state notifier for ScreenAuditScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuditNotifier extends StateNotifier<AsyncValue<void>> {
  AuditNotifier() : super(const AsyncValue.data(null));
}
