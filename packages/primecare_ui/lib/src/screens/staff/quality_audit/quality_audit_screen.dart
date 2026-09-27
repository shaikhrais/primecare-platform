import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'quality_audit_screen_controller.dart';
import 'sections/quality_audit_header_section.dart';
import 'sections/quality_audit_content_summary_section.dart';
import 'sections/quality_audit_primary_content_section.dart';
import 'sections/quality_audit_action_bar_section.dart';


class QualityAuditScreen extends ConsumerWidget {
  const QualityAuditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(quality_auditControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('QualityAudit'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(quality_auditControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('quality_audit_loading'), child: Semantics(label: 'quality_audit_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('quality_audit_screen'),
                    child: Column(
                      children: [
                        QualityAuditHeaderSection(data: state.data),
                        QualityAuditContentSummarySection(data: state.data),
                        QualityAuditPrimaryContentSection(data: state.data),
                        QualityAuditActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
