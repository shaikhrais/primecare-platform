import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primecare_mobile/core/api_config.dart';
import 'package:primecare_mobile/core/api_client.dart';

final familyMsgsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('${ApiClient.baseUrl}${ApiConfig.endpoints['clientFamilymessages']}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['messages'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class FamilyMessagesScreen extends ConsumerWidget {
  const FamilyMessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(familyMsgsProvider);

    return Scaffold(
      backgroundColor: Colors.teal.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Family Telehealth Messages'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Direct Clinical Messages', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Open Telehealth Call', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 700,
               desktopCrossAxisCount: 3,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Active Threads', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: ListView(
                              children: [
                                 _buildThreadCard('Dr. Evans', 'Doctor', 'Last message 1 hr ago', true),
                                 const SizedBox(height: 16),
                                 _buildThreadCard('Nurse Patel', 'Nurse', 'Last message 2 days ago', false),
                                 const SizedBox(height: 16),
                                 _buildThreadCard('James (PSW)', 'Caregiver', 'Last message 4 days ago', false),
                              ]
                           )
                        )
                     ]
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                     flex: 2,
                     child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           const Text('Thread: Dr. Evans (Pediatrics)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                           const SizedBox(height: 16),
                           Expanded(
                              child: PrimeCareCard(
                                 child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                       Expanded(
                                          child: asyncData.when(
                                             data: (msgs) {
                                                if (msgs.isEmpty) return const Center(child: Text('Empty Feed'));
                                                return ListView.separated(
                                                   reverse: true,
                                                   itemCount: msgs.length,
                                                   separatorBuilder: (c, i) => const SizedBox(height: 16),
                                                   itemBuilder: (c, i) => _buildMsgBubble(msgs[i]),
                                                );
                                             },
                                             loading: () => const Center(child: CircularProgressIndicator()),
                                             error: (e, st) => Center(child: Text('Error DB: \$e')),
                                          )
                                       ),
                                       const SizedBox(height: 16),
                                       Row(
                                          children: [
                                             Expanded(
                                                child: Container(
                                                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                   decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(24), border: Border.all(color: Colors.grey.shade300)),
                                                   child: const Text('Type your message...', style: TextStyle(color: Colors.black54, fontSize: 12))
                                                )
                                             ),
                                             const SizedBox(width: 16),
                                             Container(
                                                padding: const EdgeInsets.all(12),
                                                decoration: const BoxDecoration(color: Color(0xFF0F4C81), shape: BoxShape.circle),
                                                child: const Icon(Icons.send, color: Colors.white, size: 16)
                                             )
                                          ]
                                       )
                                    ]
                                 )
                              )
                           ),
                        ]
                     )
                  ),
               ]
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildThreadCard(String n, String role, String status, bool isActive) {
     return PrimeCareCard(
        child: Row(
           children: [
              CircleAvatar(backgroundColor: isActive ? const Color(0xFF0F4C81) : Colors.grey.shade200, child: Text(n[0], style: TextStyle(color: isActive ? Colors.white : Colors.black54))),
              const SizedBox(width: 16),
              Expanded(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(n, style: const TextStyle(fontWeight: FontWeight.bold)),
                       Text(role, style: TextStyle(color: Colors.teal.shade700, fontSize: 10, fontWeight: FontWeight.bold)),
                       Text(status, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                    ]
                 )
              )
           ]
        ),
        padding: const EdgeInsets.all(16),
     );
  }

  Widget _buildMsgBubble(dynamic m) {
     final date = DateTime.parse(m['timestamp']);
     final isMe = m['senderRole'] == 'FAMILY';
     
     return Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           if (!isMe) CircleAvatar(radius: 12, backgroundColor: Colors.teal.shade500, child: Text(m['senderName'][0], style: const TextStyle(color: Colors.white, fontSize: 10))),
           if (!isMe) const SizedBox(width: 8),
           Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                 color: isMe ? const Color(0xFF0F4C81) : Colors.grey.shade100,
                 borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    topRight: const Radius.circular(16),
                    bottomLeft: Radius.circular(isMe ? 16 : 0),
                    bottomRight: Radius.circular(isMe ? 0 : 16),
                 )
              ),
              child: Column(
                 crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                 children: [
                    Text(m['content'], style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('${date.month}/${date.day} ${date.hour}:${date.minute}', style: TextStyle(color: isMe ? Colors.white70 : Colors.black54, fontSize: 9)),
                 ]
              )
           ),
           if (isMe) const SizedBox(width: 8),
           if (isMe) CircleAvatar(radius: 12, backgroundColor: Colors.blueGrey, child: Text(m['senderName'][0], style: const TextStyle(color: Colors.white, fontSize: 10))),
        ]
     );
  }
}
