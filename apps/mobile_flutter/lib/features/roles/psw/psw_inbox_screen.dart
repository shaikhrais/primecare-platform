import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswInboxScreen extends StatelessWidget {
  const PswInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PrimeCareAppBar(title: 'Secure Inbox'),
      body: ResponsiveLayoutManager(
        mobile: _buildMobileLayout(),
        tablet: _buildDesktopLayout(),
        desktop: _buildDesktopLayout(),
      ),
    );
  }

  Widget _buildThreadList() {
    return ListView.separated(
      itemCount: 15,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final isSelected = index == 0;
        return Container(
          color: isSelected ? Colors.blue.shade50 : null,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text('C${index + 1}'),
            ),
            title: Text('Coordinator ${index + 1}', style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
            subtitle: const Text('Update on the upcoming shift schedule...', maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: const Text('10:42 AM', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        );
      },
    );
  }

  Widget _buildChatPane() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
          ),
          child: Row(
            children: [
              CircleAvatar(backgroundColor: Colors.blue.shade100, child: const Text('C1')),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Coordinator 1', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('Online', style: TextStyle(color: Colors.green, fontSize: 12)),
                  ],
                ),
              ),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              _buildChatBubble('Hello! Could you confirm your availability for tomorrow?', false),
              _buildChatBubble('Yes, I am available for the morning shift.', true),
              _buildChatBubble('Great, assigning it now.', false),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xFFE2E8F0)))),
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.attach_file, color: Colors.grey), onPressed: () {}),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                mini: true,
                elevation: 0,
                onPressed: () {},
                backgroundColor: const Color(0xFF1E88E5),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildChatBubble(String text, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF1E88E5) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return _buildThreadList(); // On mobile, just show threads. Tapping would push a new route in a real app.
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 1, child: _buildThreadList()),
        const VerticalDivider(width: 1, color: Color(0xFFE2E8F0)),
        Expanded(flex: 2, child: _buildChatPane()),
      ],
    );
  }
}
