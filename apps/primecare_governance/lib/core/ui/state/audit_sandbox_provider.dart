// Governance - Category: state | Purpose: Riverpod state notifier for Audit Sandbox
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuditSandboxNotifier extends StateNotifier<AsyncValue<void>> {
  AuditSandboxNotifier() : super(const AsyncValue.data(null));
}
