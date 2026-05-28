// Governance - Category: service | Purpose: Core implementation file for the Journal Club Discussion Board platform logic.
import 'package:primecare_ui/primecare_ui.dart';

final journalClubProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/education/journal_club/topics');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class JournalClubDiscussionBoardScreen extends GovernedConsumerWidget {
  const JournalClubDiscussionBoardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(journalClubProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Journal Club Discussion Board', style: theme.typography.h3),
        actions: [
          IconButton(key: const Key('journal_club_discussion_board_iconbutton_button_1'), 
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(journalClubProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.create),
              label: const Text('New Topic'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (topics) => ListView.builder(
          padding: const EdgeInsets.all(24.0),
          itemCount: topics.length,
          itemBuilder: (context, index) {
            final topic = topics[index];
            return Card(
              color: theme.colors.surface,
              margin: const EdgeInsets.only(bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          child: Icon(Icons.person, color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(topic['author'] as String, style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
                            Text(topic['time_posted'] as String, style: theme.typography.labelSmall),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(topic['title'] as String, style: theme.typography.h3),
                    const SizedBox(height: 8),
                    Text(topic['excerpt'] as String, style: theme.typography.bodyMedium, maxLines: 3, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.comment, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text('${topic['comments_count']} Comments', style: theme.typography.labelSmall),
                        const SizedBox(width: 16),
                        Icon(Icons.thumb_up, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text('${topic['likes']}', style: theme.typography.labelSmall),
                        const Spacer(),
                        TextButton(key: const Key('journal_club_discussion_board_textbutton_button_1'), 
                          onPressed: () {},
                          child: const Text('Read & Discuss'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
