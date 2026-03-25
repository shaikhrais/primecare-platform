import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/features/rn/providers/rn_patients_provider.dart';
import 'package:go_router/go_router.dart';

class RnPatientsScreen extends ConsumerWidget {
  const RnPatientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPatients = ref.watch(rnPatientsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Patient Roster')),
      body: Column(
        children: [
          const SearchFilterTabBar(),
          Expanded(
            child: asyncPatients.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load roster: $error',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref.refresh(rnPatientsProvider),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              data: (patients) {
                if (patients.isEmpty) {
                  return const Center(
                    child: Text('No assigned patients found.'),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: patients.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final p = patients[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(
                          '/rn/care-plan',
                        ); // Link logically precisely smartly
                      },
                      child: PatientAcuityCard(
                        name: p.name,
                        acuityLevel: p.acuityLevel,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const QuickCallButton(),
    );
  }
}
