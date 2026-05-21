// UPGRADED_BY_AI
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ai_chatbot_screen_controller.dart';

class AiChatbotScreen extends ConsumerWidget {
  const AiChatbotScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(aiChatbotScreenControllerProvider);
    final controller = ref.read(aiChatbotScreenControllerProvider.notifier);
    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('AI Health Assistant')),
      body: state.when(
        data: (data) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: data['messages'].length,
                itemBuilder: (context, index) {
                  final msg = data['messages'][index];
                  final isUser = msg['role'] == 'user';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(msg['text'], style: TextStyle(color: isUser ? Colors.white : Colors.black)),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(hintText: 'Ask me anything...'),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      controller.sendMessage(textController.text);
                      textController.clear();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
