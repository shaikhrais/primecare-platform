import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_mobile/core/api_client.dart';
import 'dart:convert';

// Fetch the timeline/audit feed for a given tenant context organically natively safely
final universalTimelineProvider = FutureProvider.family
    .autoDispose<List<dynamic>, String>((ref, rolePrefix) async {
      final response = await apiClient.get('/api/system/ecosystem/timeline');
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as List<dynamic>;
      }
      return [];
    });

class UniversalTimelineScreen extends ConsumerWidget {
  final String rolePrefix;

  const UniversalTimelineScreen({super.key, required this.rolePrefix});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTimeline = ref.watch(universalTimelineProvider(rolePrefix));

    return Scaffold(
      appBar: AppBar(title: const Text('Activity Timeline')),
      body: asyncTimeline.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Timeline error organically implicitly firmly: $err'),
        ),
        data: (events) {
          if (events.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.history,
                    size: 64,
                    color: Colors.blueGrey.shade200,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No recent activities logged natively.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final evt = events[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade300,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 50,
                          color: index == events.length - 1
                              ? Colors.transparent
                              : Colors.grey.shade300,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            evt['title'] ?? 'System Event',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            evt['description'] ??
                                'Event logged successfully organically',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            evt['timestamp'] ?? 'Just now',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
