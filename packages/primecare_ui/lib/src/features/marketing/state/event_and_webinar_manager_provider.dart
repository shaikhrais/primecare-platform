import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Event And Webinar Manager
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventAndWebinarManagerNotifier extends StateNotifier<AsyncValue<void>> {
  EventAndWebinarManagerNotifier() : super(const AsyncValue.data(null));
}
