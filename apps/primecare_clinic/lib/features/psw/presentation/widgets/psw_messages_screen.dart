// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class PswMessagesScreen extends ConsumerWidget {
  const PswMessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return MasterLayout(
      child: Row(
        children: [
          // Message List Sidebar
          Container(
            width: 350,
            decoration: BoxDecoration(
              color: theme.colors.surface,
              border: Border(right: BorderSide(color: theme.colors.border.withValues(alpha: 0.5))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(theme.spacing.lg),
                  child: Text('Messages', style: theme.typography.h2),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: theme.spacing.lg),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colors.background,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search messages...',
                        prefixIcon: Icon(LucideIcons.search, size: 20),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: theme.spacing.md),
                Expanded(
                  child: ListView(
                    children: [
                      _buildMessageTile(theme, name: 'Coordinator Sarah', message: 'Please confirm your shift for tomorrow.', time: '10:45 AM', unread: true),
                      _buildMessageTile(theme, name: 'RN Jessica', message: 'Client Eleanor Vance needs updated medication log.', time: 'Yesterday', unread: false),
                      _buildMessageTile(theme, name: 'Family: Arthur P.', message: 'Thank you for your help today!', time: 'Tue', unread: false),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Chat View
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(theme.spacing.lg),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    border: Border(bottom: BorderSide(color: theme.colors.border.withValues(alpha: 0.5))),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
                        child: Text('C', style: TextStyle(color: theme.colors.primary)),
                      ),
                      SizedBox(width: theme.spacing.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Coordinator Sarah', style: theme.typography.h4),
                          Text('Online', style: theme.typography.labelMedium.copyWith(color: theme.colors.success)),
                        ],
                      ),
                      Spacer(),
                      IconButton(icon: Icon(LucideIcons.moreVertical), onPressed: () {}),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(theme.spacing.lg),
                    children: [
                      _buildChatMessage(theme, message: 'Hi, are you available to cover a shift tomorrow morning?', isMe: false, time: '10:42 AM'),
                      _buildChatMessage(theme, message: 'Yes, I am available. What time?', isMe: true, time: '10:44 AM'),
                      _buildChatMessage(theme, message: 'Please confirm your shift for tomorrow. 8AM to 12PM.', isMe: false, time: '10:45 AM'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(theme.spacing.md),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    border: Border(top: BorderSide(color: theme.colors.border.withValues(alpha: 0.5))),
                  ),
                  child: Row(
                    children: [
                      IconButton(icon: Icon(LucideIcons.paperclip), onPressed: () {}),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.colors.background,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: theme.spacing.sm),
                      CircleAvatar(
                        backgroundColor: theme.colors.primary,
                        child: IconButton(
                          icon: Icon(LucideIcons.send, color: Colors.white, size: 18),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTile(PrimeThemeData theme, {required String name, required String message, required String time, required bool unread}) {
    return Container(
      color: unread ? theme.colors.primary.withValues(alpha: 0.05) : Colors.transparent,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colors.primary.withValues(alpha: 0.1),
          child: Text(name.substring(0, 1), style: TextStyle(color: theme.colors.primary)),
        ),
        title: Text(name, style: theme.typography.bodyLarge.copyWith(fontWeight: unread ? FontWeight.bold : FontWeight.normal)),
        subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.typography.bodyMedium),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(time, style: theme.typography.labelMedium.copyWith(color: unread ? theme.colors.primary : null)),
            if (unread)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: theme.colors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatMessage(PrimeThemeData theme, {required String message, required bool isMe, required String time}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? theme.colors.primary : theme.colors.surface,
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(16),
            bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(4),
          ),
          boxShadow: [
            if (!isMe)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              message,
              style: theme.typography.bodyLarge.copyWith(
                color: isMe ? Colors.white : theme.colors.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              time,
              style: theme.typography.labelMedium.copyWith(
                color: isMe ? Colors.white.withValues(alpha: 0.7) : theme.colors.onSurface.withValues(alpha: 0.5),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
