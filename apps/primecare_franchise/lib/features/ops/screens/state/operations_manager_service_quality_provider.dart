// Governance - Category: state | Purpose: Riverpod state notifier for Operations Manager Service Quality
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class OperationsManagerServiceQualityNotifier extends StateNotifier<AsyncValue<void>> {
  OperationsManagerServiceQualityNotifier() : super(const AsyncValue.data(null));
}
