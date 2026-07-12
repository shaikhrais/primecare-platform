import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'client_issue_screen_controller.dart';
import 'sections/client_issue_header_section.dart';
import 'sections/client_issue_content_summary_section.dart';
import 'sections/client_issue_primary_content_section.dart';
import 'sections/client_issue_action_bar_section.dart';


class ClientIssueScreen extends ConsumerWidget {
  const ClientIssueScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(client_issueControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClientIssue'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(client_issueControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('client_issue_loading'), child: Semantics(label: 'client_issue_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('client_issue_screen'),
                    child: Column(
                      children: [
                        ClientIssueHeaderSection(data: state.data),
                        ClientIssueContentSummarySection(data: state.data),
                        ClientIssuePrimaryContentSection(data: state.data),
                        ClientIssueActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
