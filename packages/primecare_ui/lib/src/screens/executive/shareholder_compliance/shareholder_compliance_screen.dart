import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'shareholder_compliance_screen_controller.dart';
import 'sections/shareholder_compliance_header_section.dart';
import 'sections/shareholder_compliance_content_summary_section.dart';
import 'sections/shareholder_compliance_primary_content_section.dart';
import 'sections/shareholder_compliance_action_bar_section.dart';


class ShareholderComplianceScreen extends ConsumerWidget {
  const ShareholderComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shareholder_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ShareholderCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(shareholder_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('shareholder_compliance_loading'), child: Semantics(label: 'shareholder_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('shareholder_compliance_screen'),
                    child: Column(
                      children: [
                        ShareholderComplianceHeaderSection(data: state.data),
                        ShareholderComplianceContentSummarySection(data: state.data),
                        ShareholderCompliancePrimaryContentSection(data: state.data),
                        ShareholderComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
