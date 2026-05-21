// UPGRADED_BY_AI
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'intake_coordinator_assessments_screen_controller.dart';

class IntakeCoordinatorAssessmentsScreen extends ConsumerWidget {
  const IntakeCoordinatorAssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = const AsyncValue.data({"kpis": [], "items": []});

    return Scaffold(
      appBar: AppBar(
        title: const Text('IntakeCoordinatorAssessments'),
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
                onPressed: () {},
                child: const Text('Save / Submit Data'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
