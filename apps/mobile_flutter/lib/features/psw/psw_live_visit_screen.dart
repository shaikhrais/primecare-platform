import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/features/psw/providers/psw_evv_provider.dart';

class PswLiveVisitScreen extends ConsumerWidget {
  const PswLiveVisitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeVisitAsync = ref.watch(pswEvvLiveProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Live EVV Tracker')),
      body: activeVisitAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error linking EVV: $err')),
        data: (visit) {
          if (visit == null) {
            return const Center(
              child: Text('No active shifts available for EVV binding.'),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Patient: ${visit.patientName}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const LiveGeolocationMapLoader(),
                const SizedBox(height: 20),
                const SlideToClockInWidget(),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Care Plan Checklist',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: visit.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskChecklistNode(label: visit.tasks[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: const IncidentReportFab(),
    );
  }
}
