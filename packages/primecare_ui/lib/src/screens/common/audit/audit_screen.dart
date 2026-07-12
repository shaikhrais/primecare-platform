import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'audit_screen_controller.dart';
import 'sections/screen_audit_header_section.dart';
import 'sections/screen_audit_content_summary_section.dart';
import 'sections/screen_audit_primary_content_section.dart';
import 'sections/screen_audit_action_bar_section.dart';


class ScreenAuditScreen extends ConsumerWidget {
  const ScreenAuditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(screen_auditControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text(' Audit'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(screen_auditControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('screen_audit_loading'), child: Semantics(label: 'screen_audit_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('screen_audit_screen'),
                    child: Column(
                      children: [
                        ScreenAuditHeaderSection(data: state.data),
                        ScreenAuditContentSummarySection(data: state.data),
                        ScreenAuditPrimaryContentSection(data: state.data),
                        ScreenAuditActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
