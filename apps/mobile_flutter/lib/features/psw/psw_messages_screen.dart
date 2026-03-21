import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:flutter/services.dart';
import '../shared/layouts/master_detail_layout.dart';
import 'psw_chat_thread_screen.dart';

class PswMessagesScreen extends StatefulWidget {
  const PswMessagesScreen({super.key});

  @override
  State<PswMessagesScreen> createState() => _PswMessagesScreenState();
}

class _PswMessagesScreenState extends State<PswMessagesScreen> {
  final List<Map<String, dynamic>> _threads = const [
    {'id': 't_1', 'sender': 'Jessica (Dispatch)', 'message': 'New Urgent Shift Available', 'time': '10:45 AM', 'unread': true},
    {'id': 't_2', 'sender': 'Sarah (Clinical RN)', 'message': 'Please review the updated Care Plan.', 'time': 'Yesterday', 'unread': false},
    {'id': 't_3', 'sender': 'Auto-Comms', 'message': 'Your CPR Certificate expires in 14 days.', 'time': 'Oct 24', 'unread': false},
  ];

  String? _selectedThreadId;
  String? _selectedThreadTitle;

  void _onThreadSelected(String id, String title, bool isDesktop) {
    HapticFeedback.lightImpact();
    if (isDesktop) {
      setState(() {
        _selectedThreadId = id;
        _selectedThreadTitle = title;
      });
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => PswChatThreadScreen(threadId: id, title: title))
      );
    }
  }

  void _onBackToMaster() {
    setState(() {
      _selectedThreadId = null;
      _selectedThreadTitle = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    final masterListWidget = Scaffold(
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
          final isSelected = _selectedThreadId == thread['id'];
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => _onThreadSelected(thread['id'], thread['sender'], isDesktop),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected && isDesktop ? const Color(0xFFE0E7FF) : (thread['unread'] ? Colors.white : const Color(0xFFF1F5F9)),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected && isDesktop 
                        ? const Color(0xFF6366F1) 
                        : (thread['unread'] ? const Color(0xFF3B82F6) : PrimeCareColors.slate200), 
                    width: (isSelected && isDesktop) || thread['unread'] ? 2 : 1
                  ),
                  boxShadow: thread['unread'] && !(isSelected && isDesktop) ? const [BoxShadow(color: Color(0x113B82F6), blurRadius: 16, offset: Offset(0, 4))] : [],
                ),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: thread['unread'] || (isSelected && isDesktop) ? const Color(0xFFDBEAFE) : PrimeCareColors.slate200,
                      child: Icon(Icons.person, color: thread['unread'] || (isSelected && isDesktop) ? const Color(0xFF3B82F6) : PrimeCareColors.slate500, size: 28),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(thread['sender'], style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: PrimeCareColors.radarDark)),
                              Text(thread['time'], style: TextStyle(color: thread['unread'] || (isSelected && isDesktop) ? const Color(0xFF3B82F6) : PrimeCareColors.slate400, fontSize: 13, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            thread['message'], 
                            style: TextStyle(color: thread['unread'] || (isSelected && isDesktop) ? PrimeCareColors.radarDark : PrimeCareColors.slate500, fontSize: 14, fontWeight: thread['unread'] ? FontWeight.bold : FontWeight.normal),
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

    return MasterDetailLayout(
      masterList: masterListWidget,
      detailView: _selectedThreadId != null 
          ? PswChatThreadScreen(threadId: _selectedThreadId!, title: _selectedThreadTitle!)
          : Container(
              color: const Color(0xFFF1F5F9), 
              child: const Center(
                child: Text('Select a message to view the thread.', style: TextStyle(color: PrimeCareColors.slate400, fontWeight: FontWeight.bold))
              )
            ),
      isDetailActive: _selectedThreadId != null,
      onBackToMaster: _onBackToMaster,
    );
  }
}
