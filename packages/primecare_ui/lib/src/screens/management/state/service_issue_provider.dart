import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for ServiceIssueScreen
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceIssueNotifier extends StateNotifier<AsyncValue<void>> {
  ServiceIssueNotifier() : super(const AsyncValue.data(null));
}
