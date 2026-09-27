import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'client_progress_screen_controller.dart';
import 'sections/client_progress_header_section.dart';
import 'sections/client_progress_content_summary_section.dart';
import 'sections/client_progress_primary_content_section.dart';
import 'sections/client_progress_action_bar_section.dart';


class ClientProgressScreen extends ConsumerWidget {
  const ClientProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(client_progressControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ClientProgress'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(client_progressControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('client_progress_loading'), child: Semantics(label: 'client_progress_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('client_progress_screen'),
                    child: Column(
                      children: [
                        ClientProgressHeaderSection(data: state.data),
                        ClientProgressContentSummarySection(data: state.data),
                        ClientProgressPrimaryContentSection(data: state.data),
                        ClientProgressActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
