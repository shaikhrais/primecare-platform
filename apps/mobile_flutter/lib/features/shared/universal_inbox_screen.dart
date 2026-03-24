import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';
import '../../core/api_client.dart';
import 'dart:convert';

class ThreadModel {
  final String id;
  final String type;
  final String latestMessage;
  final String senderEmail;

  ThreadModel({required this.id, required this.type, required this.latestMessage, required this.senderEmail});
}

class UniversalInboxScreen extends StatefulWidget {
  final String rolePrefix;
  const UniversalInboxScreen({super.key, required this.rolePrefix});

  @override
  State<UniversalInboxScreen> createState() => _UniversalInboxScreenState();
}

class _UniversalInboxScreenState extends State<UniversalInboxScreen> {
  bool _isLoading = true;
  List<ThreadModel> _threads = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchInbox();
  }

  Future<void> _fetchInbox() async {
    try {
      final response = await apiClient.get('/v1/inbox');
      if (response != null && mounted) {
        final List<dynamic> jsonList = response is Map && response['mocked'] == true ? [] : response;
        setState(() {
          _threads = jsonList.map((j) {
            final msgs = j['messages'] as List<dynamic>? ?? [];
            return ThreadModel(
               id: j['id'],
               type: j['threadType'] ?? 'general',
               latestMessage: msgs.isNotEmpty ? msgs[0]['bodyText'] : 'Empty Thread Node.',
               senderEmail: msgs.isNotEmpty ? msgs[0]['sender']['email'] : 'System Node'
            );
          }).toList();
          _isLoading = false;
        });
      }
    } catch(e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _dispatchMessage() async {
    if (_messageController.text.isEmpty) return;
    try {
      final text = _messageController.text;
      _messageController.clear();
      Navigator.pop(context); // Close Master Compose Layout
      
      final response = await apiClient.post('/v1/inbox', {
        'threadType': 'General Broadcast => ${widget.rolePrefix.toUpperCase()}',
        'bodyText': text
      });
      
      if (response != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Physical Database Notification Dispatched.'), backgroundColor: Colors.green));
          _isLoading = true;
          setState((){});
          _fetchInbox();
        }
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edge Networking Delay Intercepted.'), backgroundColor: Colors.orange));
    }
  }

  void _showComposeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom, left: 24, right: 24, top: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.mark_email_unread_rounded, size: 36, color: Theme.of(context).primaryColor),
                const SizedBox(width: 16),
                const Text('Dispatch Framework Message', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'Direct Communication Array payload',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _dispatchMessage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              child: const Text('Execute DB Cloud Storage', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(height: 32),
          ]
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    return PrimeCareScaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showComposeSheet(context),
        backgroundColor: primary,
        icon: const Icon(Icons.maps_ugc_rounded, color: Colors.white),
        label: const Text('Compose Override', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: _isLoading 
      ? const Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.inbox_rounded, size: 48, color: primary),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('System Messaging Hub: ${widget.rolePrefix.toUpperCase()}', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
                      Text('Real-Time DB -> API Node Message Threads.', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                    ]
                  )
                ]
              ),
              const SizedBox(height: 32),
              _threads.isEmpty 
              ? PrimeCareCard(child: const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('No Message Threads Detected within Physical Schema.', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18)))))
              : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _threads.length,
                itemBuilder: (context, index) {
                   final t = _threads[index];
                   return PrimeCareCard(
                     margin: const EdgeInsets.only(bottom: 12),
                     padding: EdgeInsets.zero,
                     child: ListTile(
                       contentPadding: const EdgeInsets.all(16),
                       leading: CircleAvatar(backgroundColor: primary.withValues(alpha:0.1), child: Icon(Icons.email, color: primary)),
                       title: Text(t.type.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: primary)),
                       subtitle: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           const SizedBox(height: 4),
                           Text("Sender: ${t.senderEmail}", style: TextStyle(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.bold)),
                           const SizedBox(height: 4),
                           Text(t.latestMessage, style: TextStyle(fontSize: 15, color: Colors.grey[800])),
                         ]
                       ),
                       trailing: Icon(Icons.reply_all_rounded, color: Colors.grey, size: 20),
                       onTap: () { context.push('/${widget.rolePrefix}/inbox/thread/${t.id}'); },
                     )
                   );
                }
              )
            ]
          )
        )
    );
  }
}
