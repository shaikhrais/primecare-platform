import 'package:flutter_riverpod/legacy.dart';
import '../models/ai_chatbot_model.dart';

class AiChatbotNotifier extends StateNotifier<AiChatbotModel> {
  AiChatbotNotifier() : super(const AiChatbotModel(isLoading: true));

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    try {
      // TODO: Call API service
      state = state.copyWith(isLoading: false, data: const <String, dynamic>{});
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}

final ai_chatbotProvider = StateNotifierProvider<AiChatbotNotifier, AiChatbotModel>((ref) {
  return AiChatbotNotifier()..loadData();
});
