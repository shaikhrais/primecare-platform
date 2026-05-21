import 'package:flutter/material.dart';

class PswMessagingScreen extends StatefulWidget {
  const PswMessagingScreen({Key? key}) : super(key: key);

  @override
  State<PswMessagingScreen> createState() => _PswMessagingScreenState();
}

class _PswMessagingScreenState extends State<PswMessagingScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'sender': 'Jane Smith (RN)', 'text': 'Please check vitals in room 402.', 'isMe': false},
    {'sender': 'Me', 'text': 'Will do. I am heading there now.', 'isMe': true},
    {'sender': 'Dr. Brown', 'text': 'Medication updated for Mr. Doe.', 'isMe': false},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Clinical Messaging'), backgroundColor: Colors.teal),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return Align(
                    alignment: msg['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: msg['isMe'] ? Colors.teal.shade100 : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(msg['sender'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade700)),
                          const SizedBox(height: 4),
                          Text(msg['text'], style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a secure message...',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.teal),
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          _messages.add({'sender': 'Me', 'text': _messageController.text, 'isMe': true});
                          _messageController.clear();
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}