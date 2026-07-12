import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_patient_charting_screen_controller.dart';
import 'sections/rn_patient_charting_header_section.dart';
import 'sections/rn_patient_charting_content_summary_section.dart';
import 'sections/rn_patient_charting_primary_content_section.dart';
import 'sections/rn_patient_charting_action_bar_section.dart';


class RnPatientChartingScreen extends ConsumerWidget {
  const RnPatientChartingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_patient_chartingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnPatientCharting'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_patient_chartingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_patient_charting_loading'), child: Semantics(label: 'rn_patient_charting_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_patient_charting_screen'),
                    child: Column(
                      children: [
                        RnPatientChartingHeaderSection(data: state.data),
                        RnPatientChartingContentSummarySection(data: state.data),
                        RnPatientChartingPrimaryContentSection(data: state.data),
                        RnPatientChartingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
