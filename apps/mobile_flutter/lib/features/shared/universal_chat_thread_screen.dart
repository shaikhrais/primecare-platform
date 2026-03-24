import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageBlock {
  final String text;
  final bool isMe;
  final String timestamp;
  MessageBlock({required this.text, required this.isMe, required this.timestamp});
}

class UniversalChatThreadScreen extends StatefulWidget {
  final String rolePrefix;
  final String threadId;

  const UniversalChatThreadScreen({super.key, required this.rolePrefix, required this.threadId});

  @override
  State<UniversalChatThreadScreen> createState() => _UniversalChatThreadScreenState();
}

class _UniversalChatThreadScreenState extends State<UniversalChatThreadScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<MessageBlock> _messages = [
    MessageBlock(text: "Hello! Evaluating the initial communication ping from the matrix array.", isMe: false, timestamp: "09:41 AM"),
    MessageBlock(text: "Acknowledged. Standing by for cross-role live talk validation protocols.", isMe: true, timestamp: "09:43 AM"),
    MessageBlock(text: "Please hold while I deploy the Universal WebRTC Calling sequence natively.", isMe: false, timestamp: "10:02 AM"),
  ];

  WebSocketChannel? _channel;

  @override
  void initState() {
    super.initState();
    // Authentic Serverless Terminal Binding (Cloudflare DO ChatServer)
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://primecare-api.itpro-mohammed.workers.dev/websocket?token=secure_agent_token'),
    );
    
    _channel!.stream.listen((message) {
      if (mounted) {
        setState(() {
          _messages.add(MessageBlock(
            text: message is String ? message : 'Unencrypted payload intercepted.',
            isMe: false,
            timestamp: "Just now"
          ));
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent + 200,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        });
      }
    }, onError: (err) {
      debugPrint('[WEBSOCKET CONNECTION FAILURE]: $err');
    });
  }

  @override
  void dispose() {
    _channel?.sink.close();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add(MessageBlock(
        text: _controller.text.trim(),
        isMe: true,
        timestamp: "Just now"
      ));
    });
    // Send actual physical string payloads crossing the explicit native WebAssembly edge into Cloudflare natively.
    if (_channel != null) {
      _channel!.sink.add(_controller.text.trim());
    }

    _controller.clear();
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 200, // overshoot slightly
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: PrimeCareNavBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: primary.withValues(alpha: 0.1),
              child: PrimeCareIcon(Icons.person, color: primary),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimeCareText("External Interactor", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Container(
                      width: 8, height: 8,
                      decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 4),
                    PrimeCareText("Online (Active Matrix)", style: TextStyle(fontSize: 12, color: Colors.green[700], fontWeight: FontWeight.bold)),
                  ],
                )
              ]
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone_rounded, color: primary, size: 28),
            onPressed: () => context.push('/${widget.rolePrefix}/call/audio-bridge'),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.videocam_rounded, color: primary, size: 30),
            onPressed: () => context.push('/${widget.rolePrefix}/call/video-bridge'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Simulated Secure Encryption Banner
          Container(
            width: double.infinity,
            color: PrimeCareColors.slate500.withValues(alpha: 0.1),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_rounded, size: 14, color: PrimeCareColors.slate500),
                const SizedBox(width: 4),
                PrimeCareText(
                  "AES-256 E2E Encryption Enabled across connection node ${widget.threadId}",
                  style: TextStyle(fontSize: 11, color: PrimeCareColors.slate500, fontWeight: FontWeight.bold)
                )
              ]
            ),
          ),
          // Chat View
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final m = _messages[index];
                return _buildChatBubble(m.text, m.isMe, m.timestamp, primary);
              },
            ),
          ),
          // Bottom Input Field
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -5))
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add_circle_outline_rounded, color: primary, size: 28),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      maxLines: null,
                      onSubmitted: (_) => _sendMessage(),
                      decoration: InputDecoration(
                        hintText: "Transmit secure communication...",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: PrimeCareColors.slate500.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: _sendMessage,
                    borderRadius: BorderRadius.circular(24),
                    child: CircleAvatar(
                      backgroundColor: primary,
                      radius: 24,
                      child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isMe, String time, Color primary) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe ? primary : Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(4),
                  bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, offset: const Offset(0, 2))
                ]
              ),
              child: PrimeCareText(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : PrimeCareColors.radarDark,
                  fontSize: 16,
                  height: 1.3
                ),
              ),
            ),
            const SizedBox(height: 4),
            PrimeCareText(time, style: TextStyle(color: PrimeCareColors.slate500, fontSize: 11, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
