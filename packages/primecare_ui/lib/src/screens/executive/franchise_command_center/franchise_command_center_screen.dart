import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'franchise_command_center_screen_controller.dart';
import 'sections/franchise_command_center_header_section.dart';
import 'sections/franchise_command_center_content_summary_section.dart';
import 'sections/franchise_command_center_primary_content_section.dart';
import 'sections/franchise_command_center_action_bar_section.dart';


class FranchiseCommandCenterScreen extends ConsumerWidget {
  const FranchiseCommandCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchise_command_centerControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FranchiseCommandCenter'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(franchise_command_centerControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('franchise_command_center_loading'), child: Semantics(label: 'franchise_command_center_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('franchise_command_center_screen'),
                    child: Column(
                      children: [
                        FranchiseCommandCenterHeaderSection(data: state.data),
                        FranchiseCommandCenterContentSummarySection(data: state.data),
                        FranchiseCommandCenterPrimaryContentSection(data: state.data),
                        FranchiseCommandCenterActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
