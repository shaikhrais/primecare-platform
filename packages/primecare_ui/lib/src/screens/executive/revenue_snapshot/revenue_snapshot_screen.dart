import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'revenue_snapshot_screen_controller.dart';
import 'sections/revenue_snapshot_header_section.dart';
import 'sections/revenue_snapshot_content_summary_section.dart';
import 'sections/revenue_snapshot_primary_content_section.dart';
import 'sections/revenue_snapshot_action_bar_section.dart';


class RevenueSnapshotScreen extends ConsumerWidget {
  const RevenueSnapshotScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(revenue_snapshotControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RevenueSnapshot'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(revenue_snapshotControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('revenue_snapshot_loading'), child: Semantics(label: 'revenue_snapshot_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('revenue_snapshot_screen'),
                    child: Column(
                      children: [
                        RevenueSnapshotHeaderSection(data: state.data),
                        RevenueSnapshotContentSummarySection(data: state.data),
                        RevenueSnapshotPrimaryContentSection(data: state.data),
                        RevenueSnapshotActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
