import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'social_worker_compliance_screen_controller.dart';
import 'sections/social_worker_compliance_header_section.dart';
import 'sections/social_worker_compliance_content_summary_section.dart';
import 'sections/social_worker_compliance_primary_content_section.dart';
import 'sections/social_worker_compliance_action_bar_section.dart';


class SocialWorkerComplianceScreen extends ConsumerWidget {
  const SocialWorkerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(social_worker_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SocialWorkerCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(social_worker_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('social_worker_compliance_loading'), child: Semantics(label: 'social_worker_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('social_worker_compliance_screen'),
                    child: Column(
                      children: [
                        SocialWorkerComplianceHeaderSection(data: state.data),
                        SocialWorkerComplianceContentSummarySection(data: state.data),
                        SocialWorkerCompliancePrimaryContentSection(data: state.data),
                        SocialWorkerComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
