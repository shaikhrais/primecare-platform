import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'family_member_compliance_screen_controller.dart';
import 'sections/family_member_compliance_header_section.dart';
import 'sections/family_member_compliance_content_summary_section.dart';
import 'sections/family_member_compliance_primary_content_section.dart';
import 'sections/family_member_compliance_action_bar_section.dart';


class FamilyMemberComplianceScreen extends ConsumerWidget {
  const FamilyMemberComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(family_member_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('FamilyMemberCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(family_member_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('family_member_compliance_loading'), child: Semantics(label: 'family_member_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('family_member_compliance_screen'),
                    child: Column(
                      children: [
                        FamilyMemberComplianceHeaderSection(data: state.data),
                        FamilyMemberComplianceContentSummarySection(data: state.data),
                        FamilyMemberCompliancePrimaryContentSection(data: state.data),
                        FamilyMemberComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
