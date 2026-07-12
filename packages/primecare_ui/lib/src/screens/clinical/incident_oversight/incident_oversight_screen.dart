import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'incident_oversight_screen_controller.dart';
import 'sections/incident_oversight_header_section.dart';
import 'sections/incident_oversight_content_summary_section.dart';
import 'sections/incident_oversight_primary_content_section.dart';
import 'sections/incident_oversight_action_bar_section.dart';


class IncidentOversightScreen extends ConsumerWidget {
  const IncidentOversightScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(incident_oversightControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('IncidentOversight'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(incident_oversightControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('incident_oversight_loading'), child: Semantics(label: 'incident_oversight_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('incident_oversight_screen'),
                    child: Column(
                      children: [
                        IncidentOversightHeaderSection(data: state.data),
                        IncidentOversightContentSummarySection(data: state.data),
                        IncidentOversightPrimaryContentSection(data: state.data),
                        IncidentOversightActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
