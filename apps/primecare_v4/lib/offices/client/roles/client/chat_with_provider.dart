import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class ChatWithProviderView extends StatelessWidget {
  const ChatWithProviderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                _buildMsg('Secure terminal initialized. All clinical chats are end-to-end encrypted.', true, Colors.indigo),
                _buildMsg('Hello Arthur, how are you feeling after the physio session?', false, AppTheme.primary),
                _buildMsg('A bit of stiffness, but overall much better. Thank you.', true, Colors.teal),
              ],
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildMsg(String text, bool isMe, Color color) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isMe ? color.withOpacity(0.1) : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
          ),
        ),
        child: Text(text, style: TextStyle(fontWeight: isMe ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }

  Widget _buildChatInput() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: GlassSurface(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            const Expanded(child: TextField(decoration: InputDecoration(hintText: 'Type your secure message...', border: InputBorder.none))),
            IconButton(icon: const Icon(Icons.send, color: AppTheme.primary), onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
