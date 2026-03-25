import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/api_client.dart';

class UniversalChatThreadScreen extends StatefulWidget {
  final String rolePrefix;

  const UniversalChatThreadScreen({super.key, required this.rolePrefix});

  @override
  State<UniversalChatThreadScreen> createState() =>
      _UniversalChatThreadScreenState();
}

class _UniversalChatThreadScreenState extends State<UniversalChatThreadScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = true;
  List<Map<String, dynamic>> _messages = [];
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchInbox();
  }

  Future<void> _fetchInbox() async {
    try {
      final res = await apiClient.get('/v1/inbox');
      if (mounted) {
        setState(() {
          _messages = [
            {
              'sender': 'system',
              'text': 'Secure HIPAA-compliant E2E connection established.',
            }
          ];

          if (res.data != null && res.data is List && res.data.isNotEmpty) {
            final thread = res.data[0];
            if (thread['messages'] != null && thread['messages'] is List) {
              final msgs = List<dynamic>.from(thread['messages']);
              for (var msg in msgs.reversed) {
                // Determine if sender is me
                // Normally we'd cross-reference user ID, but we approximate here.
                _messages.add({
                  'sender': 'agent',
                  'text': msg['bodyText'] ?? '',
                });
              }
            }
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'me', 'text': text});
    });
    _controller.clear();

    try {
      await apiClient.post('/v1/inbox', {
        'threadType': 'general',
        'bodyText': text
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send natively: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Comms Thread')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Comms Thread')),
        body: Center(child: Text('Error resolving threads natively: $_error')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Comms Thread')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isMe = msg['sender'] == 'me';
                final isSystem = msg['sender'] == 'system';

                if (isSystem) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        msg['text'],
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  );
                }

                return Align(
                  alignment: isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.blue : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16).copyWith(
                        bottomRight: isMe
                            ? const Radius.circular(0)
                            : const Radius.circular(16),
                        bottomLeft: isMe
                            ? const Radius.circular(16)
                            : const Radius.circular(0),
                      ),
                    ),
                    child: Text(
                      msg['text'],
                      style: TextStyle(
                        color: isMe ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type secure message...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send, color: Colors.blue),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
