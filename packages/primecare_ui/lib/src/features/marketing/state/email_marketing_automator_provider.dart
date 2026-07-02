// Governance - Category: state | Purpose: Riverpod state notifier for Email Marketing Automator
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailMarketingAutomatorNotifier extends StateNotifier<AsyncValue<void>> {
  EmailMarketingAutomatorNotifier() : super(const AsyncValue.data(null));
}
