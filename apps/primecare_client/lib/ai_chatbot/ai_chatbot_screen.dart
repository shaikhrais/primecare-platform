import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/ai_chatbot_header_section.dart';
import 'sections/ai_chatbot_content_summary_section.dart';
import 'sections/ai_chatbot_primary_content_section.dart';
import 'sections/ai_chatbot_action_bar_section.dart';

class AiChatbotScreen extends StatelessWidget {
  const AiChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'ai_chatbot',
      title: 'Ai Chatbot',
      child: Column(
        children: const [
          const AiChatbotHeaderSection(),
          const AiChatbotContentSummarySection(),
          const AiChatbotPrimaryContentSection(),
          const AiChatbotActionBarSection(),
        ],
      ),
    );
  }
}
