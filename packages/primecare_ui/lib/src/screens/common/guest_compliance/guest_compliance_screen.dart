import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'guest_compliance_screen_controller.dart';
import 'sections/guest_compliance_header_section.dart';
import 'sections/guest_compliance_content_summary_section.dart';
import 'sections/guest_compliance_primary_content_section.dart';
import 'sections/guest_compliance_action_bar_section.dart';


class GuestComplianceScreen extends ConsumerWidget {
  const GuestComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(guest_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('GuestCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(guest_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('guest_compliance_loading'), child: Semantics(label: 'guest_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('guest_compliance_screen'),
                    child: Column(
                      children: [
                        GuestComplianceHeaderSection(data: state.data),
                        GuestComplianceContentSummarySection(data: state.data),
                        GuestCompliancePrimaryContentSection(data: state.data),
                        GuestComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
