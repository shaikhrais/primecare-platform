import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'policy_management_screen_controller.dart';
import 'sections/policy_management_header_section.dart';
import 'sections/policy_management_content_summary_section.dart';
import 'sections/policy_management_primary_content_section.dart';
import 'sections/policy_management_action_bar_section.dart';


class PolicyManagementScreen extends ConsumerWidget {
  const PolicyManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(policy_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PolicyManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(policy_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('policy_management_loading'), child: Semantics(label: 'policy_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('policy_management_screen'),
                    child: Column(
                      children: [
                        PolicyManagementHeaderSection(data: state.data),
                        PolicyManagementContentSummarySection(data: state.data),
                        PolicyManagementPrimaryContentSection(data: state.data),
                        PolicyManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
