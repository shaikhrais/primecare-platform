import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'service_issue_screen_controller.dart';
import 'sections/service_issue_header_section.dart';
import 'sections/service_issue_content_summary_section.dart';
import 'sections/service_issue_primary_content_section.dart';
import 'sections/service_issue_action_bar_section.dart';


class ServiceIssueScreen extends ConsumerWidget {
  const ServiceIssueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(service_issueControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ServiceIssue'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(service_issueControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('service_issue_loading'), child: Semantics(label: 'service_issue_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('service_issue_screen'),
                    child: Column(
                      children: [
                        ServiceIssueHeaderSection(data: state.data),
                        ServiceIssueContentSummarySection(data: state.data),
                        ServiceIssuePrimaryContentSection(data: state.data),
                        ServiceIssueActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
