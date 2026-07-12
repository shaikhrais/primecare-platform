import 'package:flutter_riverpod/legacy.dart';
// Governance - Category: state | Purpose: Riverpod state notifier for Message Archiveer
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageArchiveerNotifier extends StateNotifier<AsyncValue<void>> {
  MessageArchiveerNotifier() : super(const AsyncValue.data(null));
}
