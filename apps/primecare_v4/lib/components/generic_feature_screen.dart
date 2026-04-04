
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/dynamic_page_providers.dart';
import '../office/components/glass_surface.dart';

class GenericFeatureScreen extends ConsumerWidget {
  final String featureId;
  const GenericFeatureScreen({super.key, required this.featureId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(dynamicPageProvider(featureId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              featureId.replaceAll('_', ' ').toUpperCase(),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF006565)),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GlassSurface(
                padding: const EdgeInsets.all(24),
                child: asyncData.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, st) => Center(child: Text('Error loading $featureId: $e')),
                  data: (items) {
                    if (items.isEmpty) {
                      return const Center(child: Text('No records found.', style: TextStyle(color: Colors.blueGrey)));
                    }
                    return ListView.separated(
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const Divider(color: Colors.blueGrey, height: 24, thickness: 0.1),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.teal.withValues(alpha: 0.1), shape: BoxShape.circle),
                              child: const Icon(Icons.api, color: Colors.teal, size: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(child: Text(item['title'] ?? 'Record', style: const TextStyle(fontWeight: FontWeight.w600))),
                            Text(item['status'] ?? 'Active', style: const TextStyle(color: Colors.teal, fontWeight: FontWeight.w600)),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
