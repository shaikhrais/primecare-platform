// Governance - Category: service | Purpose: Core implementation file for the Secure Message Center platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final messagesProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/messages/inbox');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class SecureMessageCenterScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for viewing, composing, and managing messages, along with APIs for message operations and responsive design for multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'MessageList',
        'SearchBar',
        'RefreshButton',
        'ComposeMessageButton',
        'MessageDetailView',
        'ReplyButton',
        'ArchiveButton',
        'FileAttachment',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchMessages',
        'searchMessages',
        'refreshInbox',
        'composeMessage',
        'viewMessageDetails',
        'replyToMessage',
        'archiveMessage',
        'attachFile',
      ];

  const SecureMessageCenterScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final messageState = ref.watch(messagesProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        title: Text(
          'Secure HIPAA Messaging',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(key: const Key('secure_message_center_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(messagesProvider),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.create),
            label: const Text('Compose'),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: messageState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Failed to load messages: $error', style: TextStyle(color: theme.colors.error)),
        ),
        data: (messages) => Row(
          children: [
            // Inbox List
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: theme.colors.surface,
                border: Border(right: BorderSide(color: theme.colors.border)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(key: const Key('secure_message_center_textfield_input_1'), 
                      decoration: InputDecoration(
                        hintText: 'Search Inbox...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: theme.colors.background,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: messages.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final msg = messages[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: theme.colors.primary.withOpacity(0.1),
                            child: Text((msg['sender'] as String?)?.substring(0, 1) ?? '?'),
                          ),
                          title: Text(msg['subject'] as String? ?? 'No Subject', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(msg['preview'] as String? ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
                          trailing: Text(msg['time'] as String? ?? '', style: theme.typography.labelSmall),
                          selected: index == 0,
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Message View
            Expanded(
              child: Container(
                color: theme.colors.background,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        border: Border(bottom: BorderSide(color: theme.colors.border)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Patient Care Update - Room 204', style: theme.typography.h3),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  CircleAvatar(radius: 12, backgroundColor: theme.colors.primary),
                                  const SizedBox(width: 8),
                                  Text('From: Dr. Emily Chen', style: theme.typography.bodyLarge),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(key: const Key('secure_message_center_iconbutton_button_2'), icon: const Icon(Icons.reply), onPressed: () {}),
                              IconButton(key: const Key('secure_message_center_iconbutton_button_3'), icon: const Icon(Icons.archive), onPressed: () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          'The patient is stable. Please continue monitoring vitals every 4 hours. No changes to medication at this time.\n\nThank you,\nDr. Chen',
                          style: theme.typography.bodyLarge,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        border: Border(top: BorderSide(color: theme.colors.border)),
                      ),
                      child: Row(
                        children: [
                          IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
                          Expanded(
                            child: TextField(key: const Key('secure_message_center_textfield_input_2'), 
                              decoration: InputDecoration(
                                hintText: 'Type a secure reply...',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(key: const Key('secure_message_center_iconbutton_button_5'), 
                            icon: Icon(Icons.send, color: theme.colors.primary),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
