// Governance - Category: state | Purpose: Riverpod state notifier for Audit Log
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuditLogNotifier extends StateNotifier<AsyncValue<void>> {
  AuditLogNotifier() : super(const AsyncValue.data(null));
}
