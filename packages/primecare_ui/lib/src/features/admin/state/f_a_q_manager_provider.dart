import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for F A Q Manager
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FAQManagerNotifier extends StateNotifier<AsyncValue<void>> {
  FAQManagerNotifier() : super(const AsyncValue.data(null));
}
