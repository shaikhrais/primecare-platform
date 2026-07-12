import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'owner_compliance_screen_controller.dart';
import 'sections/owner_compliance_header_section.dart';
import 'sections/owner_compliance_content_summary_section.dart';
import 'sections/owner_compliance_primary_content_section.dart';
import 'sections/owner_compliance_action_bar_section.dart';


class OwnerComplianceScreen extends ConsumerWidget {
  const OwnerComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(owner_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('OwnerCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(owner_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('owner_compliance_loading'), child: Semantics(label: 'owner_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('owner_compliance_screen'),
                    child: Column(
                      children: [
                        OwnerComplianceHeaderSection(data: state.data),
                        OwnerComplianceContentSummarySection(data: state.data),
                        OwnerCompliancePrimaryContentSection(data: state.data),
                        OwnerComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
