// Governance - Category: state | Purpose: Riverpod state notifier for Ai Chatbot
// TODO: Implement state providers, loading triggers, and action mutations.
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiChatbotNotifier extends StateNotifier<AsyncValue<void>> {
  AiChatbotNotifier() : super(const AsyncValue.data(null));
}
