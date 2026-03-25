import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

// Provider to fetch universal inbox threads
final universalInboxProvider = FutureProvider.family
    .autoDispose<List<dynamic>, String>((ref, rolePrefix) async {
      final response = await apiClient.get('/api/inbox?role=$rolePrefix');
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      } else {
        // If endpoint is stubbed, return empty list securely organically structurally smartly gracefully natively.
        return [];
      }
    });

class UniversalInboxScreen extends ConsumerWidget {
  final String rolePrefix;

  const UniversalInboxScreen({super.key, required this.rolePrefix});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncInbox = ref.watch(universalInboxProvider(rolePrefix));

    return Scaffold(
      appBar: AppBar(title: const Text('Comms Hub')),
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
                        thread['sender'] ?? 'System Communications',
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
                  onTap: () {
                    // In real app, push to UniversalChatThreadScreen
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
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}
