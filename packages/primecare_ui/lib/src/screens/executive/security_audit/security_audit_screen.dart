import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'security_audit_screen_controller.dart';
import 'sections/security_audit_header_section.dart';
import 'sections/security_audit_content_summary_section.dart';
import 'sections/security_audit_primary_content_section.dart';
import 'sections/security_audit_action_bar_section.dart';


class SecurityAuditScreen extends ConsumerWidget {
  const SecurityAuditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(security_auditControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SecurityAudit'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(security_auditControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('security_audit_loading'), child: Semantics(label: 'security_audit_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('security_audit_screen'),
                    child: Column(
                      children: [
                        SecurityAuditHeaderSection(data: state.data),
                        SecurityAuditContentSummarySection(data: state.data),
                        SecurityAuditPrimaryContentSection(data: state.data),
                        SecurityAuditActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
