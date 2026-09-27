import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_compliance_screen_controller.dart';
import 'sections/psw_compliance_header_section.dart';
import 'sections/psw_compliance_content_summary_section.dart';
import 'sections/psw_compliance_primary_content_section.dart';
import 'sections/psw_compliance_action_bar_section.dart';


class PswComplianceScreen extends ConsumerWidget {
  const PswComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Psw Compliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_compliance_loading'), child: Semantics(label: 'psw_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_compliance_screen'),
                    child: Column(
                      children: [
                        PswComplianceHeaderSection(data: state.data),
                        PswComplianceContentSummarySection(data: state.data),
                        PswCompliancePrimaryContentSection(data: state.data),
                        PswComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
