import 'package:flutter/material.dart';
import '../shared/widgets/page_template.dart';
import '../shared/widgets/kpi_card.dart';

// Hits POST /v1/inbox/messages natively

class ClientInboxScreen extends StatelessWidget {
  const ClientInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'Secure Messages',
      subtitle: 'End-to-end encrypted chat with your care team natively',
      icon: Icons.forum,
      headerGradientColors: const [Colors.lightBlueAccent, Colors.blueAccent],
      kpiCards: const [
        UnifiedKpiCard(
          title: 'Unread',
          value: '2',
          icon: Icons.mark_email_unread,
          color: Colors.redAccent,
        ),
        UnifiedKpiCard(
          title: 'Care Team',
          value: 'Online',
          icon: Icons.medical_services,
          color: Colors.green,
        ),
      ],
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              _buildMessageTile('Clinical Coordinator', 'Your upcoming visit has been confirmed.', '10:42 AM', isUnread: true),
              const Divider(height: 1),
              _buildMessageTile('Finance Desk', 'Invoice INV-204128 was generated.', 'Yesterday', isUnread: true),
              const Divider(height: 1),
              _buildMessageTile('PSW Jane', 'I am on my way!', 'Tuesday', isUnread: false),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Composing new encrypted message payload.')),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Compose New Message'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageTile(String sender, String snippet, String time, {bool isUnread = false}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade50,
        child: Icon(Icons.person, color: Colors.blue.shade400),
      ),
      title: Text(sender, style: TextStyle(fontWeight: isUnread ? FontWeight.bold : FontWeight.normal)),
      subtitle: Text(snippet, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          if (isUnread) ...[
            const SizedBox(height: 4),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(color: Colors.redAccent, shape: BoxShape.circle),
            ),
          ],
        ],
      ),
      onTap: () {},
    );
  }
}
