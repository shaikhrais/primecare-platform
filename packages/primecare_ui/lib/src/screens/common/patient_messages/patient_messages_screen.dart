import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'patient_messages_screen_controller.dart';
import 'sections/patient_messages_header_section.dart';
import 'sections/patient_messages_content_summary_section.dart';
import 'sections/patient_messages_primary_content_section.dart';
import 'sections/patient_messages_action_bar_section.dart';


class PatientMessagesScreen extends ConsumerWidget {
  const PatientMessagesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patient_messagesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('PatientMessages'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(patient_messagesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('patient_messages_loading'), child: Semantics(label: 'patient_messages_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('patient_messages_screen'),
                    child: Column(
                      children: [
                        PatientMessagesHeaderSection(data: state.data),
                        PatientMessagesContentSummarySection(data: state.data),
                        PatientMessagesPrimaryContentSection(data: state.data),
                        PatientMessagesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
