// Governance - Category: state | Purpose: Riverpod state notifier for Remote Diagnosticser
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemoteDiagnosticserNotifier extends StateNotifier<AsyncValue<void>> {
  RemoteDiagnosticserNotifier() : super(const AsyncValue.data(null));
}
