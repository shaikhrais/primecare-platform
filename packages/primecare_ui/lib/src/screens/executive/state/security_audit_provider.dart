import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for SecurityAuditScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecurityAuditNotifier extends StateNotifier<AsyncValue<void>> {
  SecurityAuditNotifier() : super(const AsyncValue.data(null));
}
