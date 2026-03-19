import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'psw_chat_thread_screen.dart';

class PswMessagesScreen extends StatelessWidget {
  const PswMessagesScreen({super.key});

  final List<Map<String, dynamic>> _threads = const [
    {'id': 't_1', 'sender': 'Jessica (Dispatch)', 'message': 'New Urgent Shift Available', 'time': '10:45 AM', 'unread': true},
    {'id': 't_2', 'sender': 'Sarah (Clinical RN)', 'message': 'Please review the updated Care Plan.', 'time': 'Yesterday', 'unread': false},
    {'id': 't_3', 'sender': 'Auto-Comms', 'message': 'Your CPR Certificate expires in 14 days.', 'time': 'Oct 24', 'unread': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Unified Inbox', 
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        itemCount: _threads.length,
        itemBuilder: (context, index) {
          final thread = _threads[index];
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => PswChatThreadScreen(threadId: thread['id'], title: thread['sender']))
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: thread['unread'] ? Colors.white : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: thread['unread'] ? const Color(0xFF3B82F6) : const Color(0xFFE2E8F0), width: thread['unread'] ? 2 : 1),
                  boxShadow: thread['unread'] ? const [BoxShadow(color: Color(0x113B82F6), blurRadius: 16, offset: Offset(0, 4))] : [],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: thread['unread'] ? const Color(0xFFDBEAFE) : const Color(0xFFE2E8F0),
                      child: Icon(Icons.person, color: thread['unread'] ? const Color(0xFF3B82F6) : const Color(0xFF64748B), size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(thread['sender'], style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF0F172A))),
                              Text(thread['time'], style: TextStyle(color: thread['unread'] ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8), fontSize: 13, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            thread['message'], 
                            style: TextStyle(color: thread['unread'] ? const Color(0xFF0F172A) : const Color(0xFF64748B), fontSize: 14, fontWeight: thread['unread'] ? FontWeight.bold : FontWeight.normal),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
