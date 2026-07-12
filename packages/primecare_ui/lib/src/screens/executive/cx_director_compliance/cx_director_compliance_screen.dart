import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'cx_director_compliance_screen_controller.dart';
import 'sections/cx_director_compliance_header_section.dart';
import 'sections/cx_director_compliance_content_summary_section.dart';
import 'sections/cx_director_compliance_primary_content_section.dart';
import 'sections/cx_director_compliance_action_bar_section.dart';


class CxDirectorComplianceScreen extends ConsumerWidget {
  const CxDirectorComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cx_director_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CxDirectorCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(cx_director_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('cx_director_compliance_loading'), child: Semantics(label: 'cx_director_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('cx_director_compliance_screen'),
                    child: Column(
                      children: [
                        CxDirectorComplianceHeaderSection(data: state.data),
                        CxDirectorComplianceContentSummarySection(data: state.data),
                        CxDirectorCompliancePrimaryContentSection(data: state.data),
                        CxDirectorComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
