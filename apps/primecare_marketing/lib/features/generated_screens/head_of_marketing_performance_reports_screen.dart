// Governance - Category: view | Purpose: UPGRADED_BY_AI
// UPGRADED_BY_AI
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'head_of_marketing_performance_reports_screen_controller.dart';

class HeadOfMarketingPerformanceReportsScreen extends ConsumerWidget {
  const HeadOfMarketingPerformanceReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(HeadOfMarketingPerformanceReportsScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HeadOfMarketingPerformanceReports'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(HeadOfMarketingPerformanceReportsScreenControllerProvider),
          ),
        ],
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load API data: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(HeadOfMarketingPerformanceReportsScreenControllerProvider.notifier).performAction(),
        child: const Icon(Icons.add),
      ),
    );
  }


  Widget _buildContent(BuildContext context, dynamic data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Input Details', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Primary Data Field',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              initialValue: data['default_field_1'] ?? '',
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Secondary Information',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => ref.read(HeadOfMarketingPerformanceReportsScreenControllerProvider.notifier).performAction(),
                child: const Text('Save / Submit Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
