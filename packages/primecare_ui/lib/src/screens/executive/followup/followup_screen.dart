import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'followup_screen_controller.dart';
import 'sections/followup_header_section.dart';
import 'sections/followup_content_summary_section.dart';
import 'sections/followup_primary_content_section.dart';
import 'sections/followup_action_bar_section.dart';


class FollowupScreen extends ConsumerWidget {
  const FollowupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(followupControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Followup'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(followupControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('followup_loading'), child: Semantics(label: 'followup_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('followup_screen'),
                    child: Column(
                      children: [
                        FollowupHeaderSection(data: state.data),
                        FollowupContentSummarySection(data: state.data),
                        FollowupPrimaryContentSection(data: state.data),
                        FollowupActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
