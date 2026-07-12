import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_owner_finance_snapshot_screen_controller.dart';
import 'sections/franchise_owner_finance_snapshot_header_section.dart';
import 'sections/franchise_owner_finance_snapshot_content_summary_section.dart';
import 'sections/franchise_owner_finance_snapshot_primary_content_section.dart';
import 'sections/franchise_owner_finance_snapshot_action_bar_section.dart';


class FranchiseOwnerFinanceSnapshotScreen extends ConsumerWidget {
  const FranchiseOwnerFinanceSnapshotScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_owner_finance_snapshotControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseOwnerFinanceSnapshot'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_owner_finance_snapshotControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_owner_finance_snapshot_loading'), child: Semantics(label: 'franchise_owner_finance_snapshot_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_owner_finance_snapshot_screen'),
                    child: Column(
                      children: [
                        FranchiseOwnerFinanceSnapshotHeaderSection(data: state.data),
                        FranchiseOwnerFinanceSnapshotContentSummarySection(data: state.data),
                        FranchiseOwnerFinanceSnapshotPrimaryContentSection(data: state.data),
                        FranchiseOwnerFinanceSnapshotActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
