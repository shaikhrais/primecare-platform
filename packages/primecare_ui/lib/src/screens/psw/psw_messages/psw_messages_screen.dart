import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'psw_messages_screen_controller.dart';
import 'sections/psw_messages_header_section.dart';
import 'sections/psw_messages_content_summary_section.dart';
import 'sections/psw_messages_primary_content_section.dart';
import 'sections/psw_messages_action_bar_section.dart';


class MessagesScreen extends ConsumerWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(psw_messagesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Messages'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(psw_messagesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('psw_messages_loading'), child: Semantics(label: 'psw_messages_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('psw_messages_screen'),
                    child: Column(
                      children: [
                        PswMessagesHeaderSection(data: state.data),
                        PswMessagesContentSummarySection(data: state.data),
                        PswMessagesPrimaryContentSection(data: state.data),
                        PswMessagesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}

typedef PswMessagesScreen = MessagesScreen;
