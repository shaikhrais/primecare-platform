import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/adapter_providers.dart';
import '../../domain/models/visit_details_models.dart';
import '../../../../office/components/glass_surface.dart';

final visitDetailsFutureProvider = FutureProvider.family<VisitDetailsViewModel, String>((ref, visitId) async {
  final adapter = ref.watch(visitDetailsAdapterProvider);
  return adapter.getData(visitId);
});

class VisitDetailsScreen extends ConsumerWidget {
  final String visitId;
  const VisitDetailsScreen({super.key, required this.visitId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(visitDetailsFutureProvider(visitId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Visit Details'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.red))),
        data: (viewModel) => _buildVisitDetails(context, viewModel),
      ),
    );
  }

  Widget _buildVisitDetails(BuildContext context, VisitDetailsViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(viewModel.date, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: viewModel.isCompleted ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  viewModel.isCompleted ? 'Completed' : 'Upcoming',
                  style: TextStyle(color: viewModel.isCompleted ? Colors.green : Colors.orange, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(viewModel.time, style: const TextStyle(fontSize: 20, color: Colors.teal)),
          const SizedBox(height: 32),
          GlassSurface(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Attending Provider', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(height: 8),
                Text(viewModel.providerName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Visit Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          GlassSurface(
            padding: const EdgeInsets.all(24),
            child: Text(viewModel.summary, style: const TextStyle(fontSize: 16, height: 1.5)),
          )
        ],
      ),
    );
  }
}
