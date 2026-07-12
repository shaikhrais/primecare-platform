import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'training_hub_compliance_screen_controller.dart';
import 'sections/training_hub_compliance_header_section.dart';
import 'sections/training_hub_compliance_content_summary_section.dart';
import 'sections/training_hub_compliance_primary_content_section.dart';
import 'sections/training_hub_compliance_action_bar_section.dart';


class TrainingHubComplianceScreen extends ConsumerWidget {
  const TrainingHubComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(training_hub_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('TrainingHubCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(training_hub_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('training_hub_compliance_loading'), child: Semantics(label: 'training_hub_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('training_hub_compliance_screen'),
                    child: Column(
                      children: [
                        TrainingHubComplianceHeaderSection(data: state.data),
                        TrainingHubComplianceContentSummarySection(data: state.data),
                        TrainingHubCompliancePrimaryContentSection(data: state.data),
                        TrainingHubComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
