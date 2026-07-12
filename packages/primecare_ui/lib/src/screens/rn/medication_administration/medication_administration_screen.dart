import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'medication_administration_screen_controller.dart';
import 'sections/medication_administration_header_section.dart';
import 'sections/medication_administration_content_summary_section.dart';
import 'sections/medication_administration_primary_content_section.dart';
import 'sections/medication_administration_action_bar_section.dart';


class MedicationAdministrationScreen extends ConsumerWidget {
  const MedicationAdministrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(medication_administrationControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('MedicationAdministration'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(medication_administrationControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('medication_administration_loading'), child: Semantics(label: 'medication_administration_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('medication_administration_screen'),
                    child: Column(
                      children: [
                        MedicationAdministrationHeaderSection(data: state.data),
                        MedicationAdministrationContentSummarySection(data: state.data),
                        MedicationAdministrationPrimaryContentSection(data: state.data),
                        MedicationAdministrationActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
