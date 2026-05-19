import 'package:primecare_ui/primecare_ui.dart';

final eventsProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  final api = ref.read(apiClientProvider);
  final response = await api.get('/v1/marketing/events');
  return (response.data as List).cast<Map<String, dynamic>>();
});

class EventAndWebinarManagerScreen extends GovernedConsumerWidget {
  const EventAndWebinarManagerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(eventsProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        title: Text('Events & Webinars', style: theme.typography.h3),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: theme.colors.primary),
            onPressed: () => ref.invalidate(eventsProvider),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.event),
              label: const Text('Schedule Event'),
            ),
          ),
        ],
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: TextStyle(color: theme.colors.error))),
        data: (events) => Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upcoming & Past Events', style: theme.typography.h2),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    final isUpcoming = event['status'] == 'Upcoming';
                    return Card(
                      color: theme.colors.surface,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16.0),
                        leading: CircleAvatar(
                          backgroundColor: isUpcoming ? theme.colors.primary : Colors.grey,
                          child: Icon(event['type'] == 'Webinar' ? Icons.computer : Icons.location_on, color: Colors.white),
                        ),
                        title: Text(event['title'] as String, style: theme.typography.h4),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 4),
                            Text('${event['date']} • ${event['type']}', style: theme.typography.bodyMedium),
                            const SizedBox(height: 4),
                            Text('Registrants: ${event['registrants']} | Attendees: ${event['attendees'] ?? "N/A"}', style: theme.typography.labelSmall),
                          ],
                        ),
                        trailing: Chip(
                          label: Text(event['status'] as String, style: theme.typography.labelSmall.copyWith(color: isUpcoming ? Colors.white : Colors.black)),
                          backgroundColor: isUpcoming ? theme.colors.primary : Colors.grey[300],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
