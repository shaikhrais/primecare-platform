import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screen_work_item.g_controller.dart';

class ScreenWorkItem.g extends ConsumerWidget {
  const ScreenWorkItem.g({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ScreenWorkItem.gControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ScreenWorkItem.g'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(ScreenWorkItem.gControllerProvider),
          ),
        ],
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load API data: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(ScreenWorkItem.gControllerProvider.notifier).performAction(),
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildContent(BuildContext context, dynamic data) {
    final items = data['items'] as List;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search / Filter',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.withOpacity(0.1),
                  child: Text(item['id'].toString()),
                ),
                title: Text(item['title']),
                subtitle: Text(item['status']),
                trailing: PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(child: Text('View Details')),
                    const PopupMenuItem(child: Text('Edit')),
                    const PopupMenuItem(child: Text('Delete')),
                  ],
                ),
                onTap: () {},
              );
            },
          ),
        ),
      ],
    );
  }
}
