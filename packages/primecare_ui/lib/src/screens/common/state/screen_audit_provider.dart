// Governance - Category: state | Purpose: Riverpod state notifier for Screen Audit
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScreenAuditNotifier extends StateNotifier<AsyncValue<void>> {
  ScreenAuditNotifier() : super(const AsyncValue.data(null));
}
