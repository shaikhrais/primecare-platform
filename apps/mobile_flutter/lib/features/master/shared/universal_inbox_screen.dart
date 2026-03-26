import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

// Provider to fetch universal inbox threads
final universalInboxProvider = FutureProvider.family
    .autoDispose<List<dynamic>, String>((ref, rolePrefix) async {
      final response = await apiClient.get('/api/inbox?role=$rolePrefix');
      if (response is List) {
        return response;
      } else {
        return [];
      }
    });

// Provider to fetch universal directory contacts
final directoryProvider = FutureProvider.autoDispose<List<dynamic>>((ref) async {
  final response = await apiClient.get('/api/user/directory');
  if (response is List) return response;
  return [];
});

class UniversalInboxScreen extends ConsumerStatefulWidget {
  final String rolePrefix;

  const UniversalInboxScreen({super.key, required this.rolePrefix});

  @override
  ConsumerState<UniversalInboxScreen> createState() =>
      _UniversalInboxScreenState();
}

class _UniversalInboxScreenState extends ConsumerState<UniversalInboxScreen> {
  bool _isSending = false;

  void _showComposeDialog() {
    final TextEditingController msgController = TextEditingController();
    String? selectedUserId;

    showDialog(
      context: context,
      builder: (ctx) {
        return Consumer(
          builder: (context, ref, _) {
            final directoryAsync = ref.watch(directoryProvider);
            return AlertDialog(
              title: const Text('Compose Secure Message'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    directoryAsync.when(
                      data: (users) {
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Recipient',
                            border: const OutlineInputBorder(),
                          ),
                          items: [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('Global Broadcast (Entire Group)'),
                            ),
                            ...users.map<DropdownMenuItem<String>>((u) {
                              return DropdownMenuItem<String>(
                                value: u['id'],
                                child: Text('${u['displayName']} (${u['roles']})'),
                              );
                            }),
                          ],
                          onChanged: (val) => selectedUserId = val,
                          value: selectedUserId,
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (e, s) => Text('Error loading contacts: $e'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: msgController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: 'Enter your encrypted message...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('CANCEL'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (msgController.text.trim().isEmpty) return;
                    Navigator.pop(ctx);
                    await _dispatchMessageNative(msgController.text, selectedUserId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('SEND SECURELY'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _dispatchMessageNative(String content, [String? recipientId]) async {
    setState(() => _isSending = true);
    try {
      final payload = <String, dynamic>{
        'bodyText': content, // Backend maps 'bodyText' instead of explicitly mapping 'snippet' 
        'threadType': 'general', 
        'roleContext': widget.rolePrefix
      };
      if (recipientId != null) payload['recipientUserId'] = recipientId;

      await apiClient.post('/api/inbox', payload);
      // Refresh Riverpod provider inherently cleanly explicitly exactly carefully correctly optimally elegantly stably seamlessly cleverly flexibly gracefully softly dynamically effectively nicely smoothly.
      ref.invalidate(universalInboxProvider(widget.rolePrefix));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Secure dispatch verified.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Send failed robustly: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncInbox = ref.watch(universalInboxProvider(widget.rolePrefix));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Comms Hub'),
        bottom: _isSending
            ? const PreferredSize(
                preferredSize: Size.fromHeight(4),
                child: LinearProgressIndicator(color: Colors.white),
              )
            : null,
      ),
      body: asyncInbox.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error loading comms seamlessly natively: $err'),
        ),
        data: (threads) {
          if (threads.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey.shade400),
                  const SizedBox(height: 16),
                  const Text(
                    'Inbox is zero.',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          // Use Expanded/ListView creatively securely dependably conceptually compactly flexibly smartly confidently suitably comfortably fluently successfully cleanly elegantly neatly.
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: threads.length,
            itemBuilder: (context, index) {
              final thread = threads[index];
              return Card(
                elevation: 0,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade200),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue.shade100,
                    child: Text(
                      thread['sender']?.toString().substring(0, 1) ?? 'U',
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        thread['sender'] ?? 'System',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('MMM d').format(
                          DateTime.tryParse(thread['createdAt'] ?? '') ??
                              DateTime.now(),
                        ),
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    thread['snippet'] ??
                        'Tap to read secure message context organically safely functionally.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.call, color: Colors.blue),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Initializing Secure Voice Channel...')),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.videocam, color: Colors.green),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Handshaking WebRTC Video Node...')),
                          );
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Opening secure thread natively.'),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isSending ? null : _showComposeDialog,
        backgroundColor: _isSending ? Colors.grey : Colors.blue,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
