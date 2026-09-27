import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coo_branch_comparison_screen_controller.dart';
import 'sections/coo_branch_comparison_header_section.dart';
import 'sections/coo_branch_comparison_content_summary_section.dart';
import 'sections/coo_branch_comparison_primary_content_section.dart';
import 'sections/coo_branch_comparison_action_bar_section.dart';


class CooBranchComparisonScreen extends ConsumerWidget {
  const CooBranchComparisonScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coo_branch_comparisonControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CooBranchComparison'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coo_branch_comparisonControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coo_branch_comparison_loading'), child: Semantics(label: 'coo_branch_comparison_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coo_branch_comparison_screen'),
                    child: Column(
                      children: [
                        CooBranchComparisonHeaderSection(data: state.data),
                        CooBranchComparisonContentSummarySection(data: state.data),
                        CooBranchComparisonPrimaryContentSection(data: state.data),
                        CooBranchComparisonActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
