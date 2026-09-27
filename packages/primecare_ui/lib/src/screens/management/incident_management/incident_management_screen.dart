import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'incident_management_screen_controller.dart';
import 'sections/incident_management_header_section.dart';
import 'sections/incident_management_content_summary_section.dart';
import 'sections/incident_management_primary_content_section.dart';
import 'sections/incident_management_action_bar_section.dart';


class IncidentManagementScreen extends ConsumerWidget {
  const IncidentManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(incident_managementControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IncidentManagement'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(incident_managementControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('incident_management_loading'), child: Semantics(label: 'incident_management_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('incident_management_screen'),
                    child: Column(
                      children: [
                        IncidentManagementHeaderSection(data: state.data),
                        IncidentManagementContentSummarySection(data: state.data),
                        IncidentManagementPrimaryContentSection(data: state.data),
                        IncidentManagementActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
