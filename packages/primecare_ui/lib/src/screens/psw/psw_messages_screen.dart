import 'package:primecare_ui/primecare_ui.dart';

// --- Data Models ---
class PswMessage {
  final String id;
  final String sender;
  final String subject;
  final String snippet;
  final DateTime timestamp;
  final bool isRead;
  final String priority; // 'high', 'normal'

  const PswMessage({
    required this.id,
    required this.sender,
    required this.subject,
    required this.snippet,
    required this.timestamp,
    this.isRead = false,
    this.priority = 'normal',
  });

  factory PswMessage.fromJson(Map<String, dynamic> json) {
    return PswMessage(
      id: json['id'] as String? ?? '',
      sender: json['sender'] as String? ?? 'Unknown Sender',
      subject: json['subject'] as String? ?? 'No Subject',
      snippet: json['snippet'] as String? ?? '',
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : DateTime.now(),
      isRead: json['isRead'] as bool? ?? false,
      priority: json['priority'] as String? ?? 'normal',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'subject': subject,
      'snippet': snippet,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'priority': priority,
    };
  }
}

// --- Providers ---
class PswMessagesNotifier extends AsyncNotifier<List<PswMessage>> {
  @override
  Future<List<PswMessage>> build() async {
    final apiClient = ref.watch(apiClientProvider);

    try {
      final response = await apiClient.get('/v1/psw/messages');
      if (response.isSuccess && response.data != null) {
        final data = response.data as List<dynamic>;
        return data
            .map((json) => PswMessage.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(response.error ?? 'Failed to load messages');
      }
    } catch (e) {
      // Fallback for simulation or handle properly
      throw Exception('Failed to load messages: $e');
    }
  }

  Future<void> addMessage(
    String subject,
    String message,
    String priority,
  ) async {
    final currentState = state.value ?? [];
    state = const AsyncValue.loading();

    try {
      final apiClient = ref.read(apiClientProvider);

      final response = await apiClient.post(
        '/v1/psw/messages',
        body: {'subject': subject, 'message': message, 'priority': priority},
      );

      if (!response.isSuccess) {
        final statusCode = response.statusCode;
        if (statusCode == 401) {
          throw Exception('Unauthorized: Please log in again.');
        } else if (statusCode == 403) {
          throw Exception(
            'Forbidden: You do not have permission to perform this action.',
          );
        } else {
          throw Exception(
            response.error ?? 'Failed to send message (Status: $statusCode)',
          );
        }
      }

      final newMessage = PswMessage.fromJson(
        response.data as Map<String, dynamic>,
      );
      state = AsyncValue.data([newMessage, ...currentState]);
    } catch (e) {
      // Retain previous state and bubble up error
      state = AsyncValue.data(currentState);
      rethrow;
    }
  }
}

final pswMessagesProvider =
    AsyncNotifierProvider<PswMessagesNotifier, List<PswMessage>>(() {
      return PswMessagesNotifier();
    });

// --- UI ---
class PswMessagesScreen extends ConsumerWidget {
  const PswMessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(pswMessagesProvider);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text(
          'Messages',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        backgroundColor: theme.colors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(LucideIcons.edit, color: theme.colors.primary),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                backgroundColor: theme.colors.surface,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => const _ComposeMessageSheet(),
              );
            },
          ),
        ],
      ),
      body: messagesAsync.when(
        data: (messages) {
          if (messages.isEmpty) {
            return EmptyState(
              icon: LucideIcons.messageSquare,
              title: 'No Messages',
              subtitle: 'You have no new messages from your care coordinator.',
              actionLabel: 'New Message',
              onAction: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: theme.colors.surface,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  builder: (context) => const _ComposeMessageSheet(),
                );
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(pswMessagesProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final message = messages[index];
                return _MessageCard(message: message);
              },
            ),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(color: theme.colors.primary),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.alertTriangle,
                color: theme.colors.error,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text('Error loading messages', style: theme.typography.h3),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  foregroundColor: theme.colors.onPrimary,
                ),
                onPressed: () => ref.refresh(pswMessagesProvider),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  final PswMessage message;

  const _MessageCard({required this.message});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return InkWell(
      onTap: () {
        // Handle message tap
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: message.isRead
              ? theme.colors.surface
              : theme.colors.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: message.isRead
                ? theme.colors.border
                : theme.colors.primary.withValues(alpha: 0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: theme.colors.primary.withValues(
                        alpha: 0.1,
                      ),
                      child: Text(
                        message.sender[0],
                        style: TextStyle(
                          color: theme.colors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      message.sender,
                      style: theme.typography.bodyMedium.copyWith(
                        fontWeight: message.isRead
                            ? FontWeight.normal
                            : FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  _formatTime(message.timestamp),
                  style: theme.typography.labelSmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                if (message.priority == 'high') ...[
                  Icon(
                    LucideIcons.alertCircle,
                    size: 16,
                    color: theme.colors.error,
                  ),
                  const SizedBox(width: 4),
                ],
                Expanded(
                  child: Text(
                    message.subject,
                    style: theme.typography.bodyLarge.copyWith(
                      fontWeight: message.isRead
                          ? FontWeight.w500
                          : FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              message.snippet,
              style: theme.typography.bodyMedium.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    if (time.year == now.year &&
        time.month == now.month &&
        time.day == now.day) {
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    }
    return '${time.day}/${time.month}/${time.year}';
  }
}

class _ComposeMessageSheet extends ConsumerStatefulWidget {
  const _ComposeMessageSheet();

  @override
  ConsumerState<_ComposeMessageSheet> createState() =>
      _ComposeMessageSheetState();
}

class _ComposeMessageSheetState extends ConsumerState<_ComposeMessageSheet> {
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  String _priority = 'normal';
  bool _isSubmitting = false;

  @override
  void dispose() {
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_subjectController.text.isEmpty || _messageController.text.isEmpty)
      return;

    setState(() => _isSubmitting = true);
    try {
      await ref
          .read(pswMessagesProvider.notifier)
          .addMessage(
            _subjectController.text,
            _messageController.text,
            _priority,
          );
      ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/psw/messages',
            eventType: 'psw_message_sent',
            metadata: {'priority': _priority},
          );
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        final theme = context.theme;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: theme.colors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Message', style: theme.typography.h3),
              IconButton(
                icon: const Icon(LucideIcons.x),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _subjectController,
            decoration: InputDecoration(
              labelText: 'Subject',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _priority,
            decoration: InputDecoration(
              labelText: 'Priority',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: const [
              DropdownMenuItem(value: 'normal', child: Text('Normal')),
              DropdownMenuItem(value: 'high', child: Text('High')),
            ],
            onChanged: (val) {
              if (val != null) setState(() => _priority = val);
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _messageController,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primary,
              foregroundColor: theme.colors.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: _isSubmitting ? null : _submit,
            child: _isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Text('Send Message'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
