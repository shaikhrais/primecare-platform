import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'medication_screen_controller.dart';
import 'sections/medication_header_section.dart';
import 'sections/medication_content_summary_section.dart';
import 'sections/medication_primary_content_section.dart';
import 'sections/medication_action_bar_section.dart';


class MedicationScreen extends ConsumerWidget {
  const MedicationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(medicationControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('Medication'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(medicationControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('medication_loading'), child: Semantics(label: 'medication_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('medication_screen'),
                    child: Column(
                      children: [
                        MedicationHeaderSection(data: state.data),
                        MedicationContentSummarySection(data: state.data),
                        MedicationPrimaryContentSection(data: state.data),
                        MedicationActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
