import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_medications_screen_controller.dart';
import 'sections/rn_medications_header_section.dart';
import 'sections/rn_medications_content_summary_section.dart';
import 'sections/rn_medications_primary_content_section.dart';
import 'sections/rn_medications_action_bar_section.dart';


class RnMedicationsScreen extends ConsumerWidget {
  const RnMedicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_medicationsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnMedications'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_medicationsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_medications_loading'), child: Semantics(label: 'rn_medications_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_medications_screen'),
                    child: Column(
                      children: [
                        RnMedicationsHeaderSection(data: state.data),
                        RnMedicationsContentSummarySection(data: state.data),
                        RnMedicationsPrimaryContentSection(data: state.data),
                        RnMedicationsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
