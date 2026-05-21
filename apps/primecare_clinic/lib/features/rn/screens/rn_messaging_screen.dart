import 'package:flutter/material.dart';

class RnMessagingScreen extends StatefulWidget {
  const RnMessagingScreen({Key? key}) : super(key: key);

  @override
  State<RnMessagingScreen> createState() => _RnMessagingScreenState();
}

class _RnMessagingScreenState extends State<RnMessagingScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'sender': 'Dr. Adams', 'text': 'Please update the chart for Room 101.', 'isMe': false, 'time': '10:45 AM'},
    {'sender': 'Sarah (PSW)', 'text': 'Vitals check complete for Room 204.', 'isMe': false, 'time': '9:30 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Secure Team Messaging'), backgroundColor: Colors.indigo),
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
                        color: msg['isMe'] ? Colors.indigo.shade100 : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(msg['sender'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey.shade700)),
                              const SizedBox(width: 8),
                              Text(msg['time'], style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
                            ],
                          ),
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
                    icon: const Icon(Icons.send, color: Colors.indigo),
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          _messages.add({'sender': 'Me', 'text': _messageController.text, 'isMe': true, 'time': 'Just now'});
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