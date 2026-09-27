import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_command_center4_k_screen_controller.dart';
import 'sections/franchise_command_center4_k_header_section.dart';
import 'sections/franchise_command_center4_k_content_summary_section.dart';
import 'sections/franchise_command_center4_k_primary_content_section.dart';
import 'sections/franchise_command_center4_k_action_bar_section.dart';


class FranchiseCommandCenter4KScreen extends ConsumerWidget {
  const FranchiseCommandCenter4KScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_command_center4_kControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseCommandCenter4K'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_command_center4_kControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_command_center4_k_loading'), child: Semantics(label: 'franchise_command_center4_k_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_command_center4_k_screen'),
                    child: Column(
                      children: [
                        FranchiseCommandCenter4KHeaderSection(data: state.data),
                        FranchiseCommandCenter4KContentSummarySection(data: state.data),
                        FranchiseCommandCenter4KPrimaryContentSection(data: state.data),
                        FranchiseCommandCenter4KActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
