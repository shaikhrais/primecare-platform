import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../providers/adapter_providers.dart';
import '../../domain/models/client_profile_models.dart';
import '../../../../office/components/glass_surface.dart';

final clientProfileFutureProvider =
    FutureProvider.family<ClientProfileViewModel, String>((
      ref,
      profileId,
    ) async {
      final adapter = ref.watch(clientProfileAdapterProvider);
      return adapter.getData(profileId);
    });

class ClientProfileScreen extends ConsumerWidget {
  final String profileId;
  const ClientProfileScreen({super.key, required this.profileId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(clientProfileFutureProvider(profileId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Client Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: asyncData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error: $err', style: const TextStyle(color: Colors.red)),
        ),
        data: (viewModel) => _buildProfile(context, viewModel),
      ),
    );
  }

  Widget _buildProfile(BuildContext context, ClientProfileViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GlassSurface(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue.withValues(alpha: 0.1),
                  child: const Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                const SizedBox(width: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.fullName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Age: ${viewModel.age} | ID: ${viewModel.clientId}',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    viewModel.status,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Recent Diagnoses',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...viewModel.recentDiagnoses.map(
            (d) => ListTile(
              key: const Key('data-status-id=shared-global-client-action-1'),
              leading: const Icon(
                Icons.medical_services_outlined,
                color: Colors.teal,
              ),
              title: Text(
                d,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              tileColor: Colors.white.withValues(alpha: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onTap: () => ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Viewing diagnosis $d'))),
            ),
          ),
        ],
      ),
    );
  }
}
