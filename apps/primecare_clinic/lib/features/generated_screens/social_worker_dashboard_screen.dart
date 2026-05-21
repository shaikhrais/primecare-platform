// UPGRADED_BY_AI
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'social_worker_dashboard_screen_controller.dart';

class SocialWorkerDashboardScreen extends ConsumerWidget {
  const SocialWorkerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = const AsyncValue.data({"kpis": [], "items": []});

    return Scaffold(
      appBar: AppBar(
        title: const Text('SocialWorkerDashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load API data: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildContent(BuildContext context, dynamic data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Key Metrics', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.5,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: (data['kpis'] as List).map<Widget>((kpi) {
              return Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(kpi['label'], style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(kpi['value'].toString(), style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.blue)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          Text('Recent Activity', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.show_chart)),
                title: Text('Activity Event #${index + 1}'),
                subtitle: const Text('Processed successfully by the backend API.'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              );
            },
          )
        ],
      ),
    );
  }
}
