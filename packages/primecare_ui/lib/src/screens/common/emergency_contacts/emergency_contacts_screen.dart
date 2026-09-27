import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'emergency_contacts_screen_controller.dart';
import 'sections/emergency_contacts_header_section.dart';
import 'sections/emergency_contacts_content_summary_section.dart';
import 'sections/emergency_contacts_primary_content_section.dart';
import 'sections/emergency_contacts_action_bar_section.dart';


class EmergencyContactsScreen extends ConsumerWidget {
  const EmergencyContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(emergency_contactsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('EmergencyContacts'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(emergency_contactsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('emergency_contacts_loading'), child: Semantics(label: 'emergency_contacts_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('emergency_contacts_screen'),
                    child: Column(
                      children: [
                        EmergencyContactsHeaderSection(data: state.data),
                        EmergencyContactsContentSummarySection(data: state.data),
                        EmergencyContactsPrimaryContentSection(data: state.data),
                        EmergencyContactsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
