import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rpn_medications_screen_controller.dart';
import 'sections/rpn_medications_header_section.dart';
import 'sections/rpn_medications_content_summary_section.dart';
import 'sections/rpn_medications_primary_content_section.dart';
import 'sections/rpn_medications_action_bar_section.dart';


class RpnMedicationsScreen extends ConsumerWidget {
  const RpnMedicationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpn_medicationsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RpnMedications'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rpn_medicationsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rpn_medications_loading'), child: Semantics(label: 'rpn_medications_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rpn_medications_screen'),
                    child: Column(
                      children: [
                        RpnMedicationsHeaderSection(data: state.data),
                        RpnMedicationsContentSummarySection(data: state.data),
                        RpnMedicationsPrimaryContentSection(data: state.data),
                        RpnMedicationsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
