import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'deployment_center_screen_controller.dart';
import 'sections/deployment_center_header_section.dart';
import 'sections/deployment_center_content_summary_section.dart';
import 'sections/deployment_center_primary_content_section.dart';
import 'sections/deployment_center_action_bar_section.dart';


class DeploymentCenterScreen extends ConsumerWidget {
  const DeploymentCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deployment_centerControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('DeploymentCenter'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(deployment_centerControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('deployment_center_loading'), child: Semantics(label: 'deployment_center_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('deployment_center_screen'),
                    child: Column(
                      children: [
                        DeploymentCenterHeaderSection(data: state.data),
                        DeploymentCenterContentSummarySection(data: state.data),
                        DeploymentCenterPrimaryContentSection(data: state.data),
                        DeploymentCenterActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
