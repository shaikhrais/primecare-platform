import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'qa_compliance_screen_controller.dart';
import 'sections/qa_compliance_header_section.dart';
import 'sections/qa_compliance_content_summary_section.dart';
import 'sections/qa_compliance_primary_content_section.dart';
import 'sections/qa_compliance_action_bar_section.dart';


class QaComplianceScreen extends ConsumerWidget {
  const QaComplianceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(qa_complianceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('QaCompliance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(qa_complianceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('qa_compliance_loading'), child: Semantics(label: 'qa_compliance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('qa_compliance_screen'),
                    child: Column(
                      children: [
                        QaComplianceHeaderSection(data: state.data),
                        QaComplianceContentSummarySection(data: state.data),
                        QaCompliancePrimaryContentSection(data: state.data),
                        QaComplianceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
