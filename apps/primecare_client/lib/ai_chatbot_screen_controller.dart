// Governance - Category: view | Purpose: UPGRADED_BY_AI
// UPGRADED_BY_AI
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'ai_chatbot_screen_controller.g.dart';

@riverpod
class AiChatbotScreenController extends _$AiChatbotScreenController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    return {'messages': []};
  }

  Future<void> sendMessage(String text) async {
    final current = state.value?['messages'] ?? [];
    current.add({'role': 'user', 'text': text});
    state = AsyncData({'messages': current});

    try {
      final dio = Dio();
      final response = await dio.post('http://localhost:3000/api/ai-chat', data: {'prompt': text});
      final aiResponse = response.data['data']['response'];
      current.add({'role': 'ai', 'text': aiResponse});
      state = AsyncData({'messages': current});
    } catch (e) {
      current.add({'role': 'system', 'text': 'Failed to connect to AI server.'});
      state = AsyncData({'messages': current});
    }
  }
}
