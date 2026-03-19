import 'package:flutter/material.dart';
import '../../core/api_client.dart';

class PswMessagesScreen extends StatefulWidget {
  const PswMessagesScreen({super.key});

  @override
  State<PswMessagesScreen> createState() => _PswMessagesScreenState();
}

class _PswMessagesScreenState extends State<PswMessagesScreen> {
  List<dynamic> _threads = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadThreads();
  }

  Future<void> _loadThreads() async {
    try {
      final data = await apiClient.get('/v1/user/messaging/threads');
      if (mounted) setState(() { _threads = data; _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unified Inbox', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0EA5E9),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF0EA5E9)))
          : _threads.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.mark_email_read, size: 64, color: Color(0xFF94A3B8)),
                      SizedBox(height: 16),
                      Text('Inbox Caught Up.', style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, fontSize: 18)),
                      Text('No active secure messages.', style: TextStyle(color: Color(0xFF94A3B8))),
                    ],
                  ),
                )
              : ListView.separated(
                  itemCount: _threads.length,
                  separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFE2E8F0)),
                  itemBuilder: (context, index) {
                    final thread = _threads[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFE0F2FE),
                        child: Icon(
                          thread['threadType'] == 'clinical_rn' ? Icons.medical_services : Icons.group,
                          color: const Color(0xFF0EA5E9),
                        ),
                      ),
                      title: Text(thread['threadType'].toString().toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                      subtitle: Text(thread['lastMessage'] ?? 'No messages yet.', maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing: thread['unreadCount'] > 0 
                          ? Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(color: Color(0xFFE11D48), shape: BoxShape.circle),
                              child: Text(thread['unreadCount'].toString(), style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            )
                          : const Icon(Icons.chevron_right, color: Color(0xFFCBD5E1)),
                      onTap: () {
                        // Navigate to specific thread `PswChatScreen`
                      },
                    );
                  },
                ),
    );
  }
}
