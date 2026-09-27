import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Asynchronous Consultation Inbox
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsynchronousConsultationInboxNotifier extends StateNotifier<AsyncValue<void>> {
  AsynchronousConsultationInboxNotifier() : super(const AsyncValue.data(null));
}
