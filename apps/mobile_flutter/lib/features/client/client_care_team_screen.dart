import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/features/client/providers/client_care_team_provider.dart';

class ClientCareTeamScreen extends ConsumerWidget {
  const ClientCareTeamScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTeam = ref.watch(clientCareTeamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Care Team')),
      body: CustomScrollView(
        slivers: [
          const SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(child: EtaTrackerWidget()),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Assigned Dedicated Caregivers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: asyncTeam.when(
              loading: () => const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => SliverToBoxAdapter(
                child: Center(
                  child: Text('Error resolving team network payload: $err'),
                ),
              ),
              data: (team) {
                if (team.isEmpty) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No assigned caregivers found for this period.',
                      ),
                    ),
                  );
                }
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final caregiver = team[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CaregiverProfileCard(
                        name: caregiver.name,
                        role: caregiver.role,
                        rating: caregiver.rating,
                        specialty: caregiver.specialty,
                      ),
                    );
                  }, childCount: team.length),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
