import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'messaging_screen_controller.dart';
import 'sections/messaging_header_section.dart';
import 'sections/messaging_content_summary_section.dart';
import 'sections/messaging_primary_content_section.dart';
import 'sections/messaging_action_bar_section.dart';


class MessagingScreen extends ConsumerWidget {
  const MessagingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(messagingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Messaging'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(messagingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('messaging_loading'), child: Semantics(label: 'messaging_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('messaging_screen'),
                    child: Column(
                      children: [
                        MessagingHeaderSection(data: state.data),
                        MessagingContentSummarySection(data: state.data),
                        MessagingPrimaryContentSection(data: state.data),
                        MessagingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
