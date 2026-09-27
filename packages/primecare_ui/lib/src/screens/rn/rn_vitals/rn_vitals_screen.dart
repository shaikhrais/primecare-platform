import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_vitals_screen_controller.dart';
import 'sections/rn_vitals_header_section.dart';
import 'sections/rn_vitals_content_summary_section.dart';
import 'sections/rn_vitals_primary_content_section.dart';
import 'sections/rn_vitals_action_bar_section.dart';


class RnVitalsScreen extends ConsumerWidget {
  const RnVitalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_vitalsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnVitals'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_vitalsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_vitals_loading'), child: Semantics(label: 'rn_vitals_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_vitals_screen'),
                    child: Column(
                      children: [
                        RnVitalsHeaderSection(data: state.data),
                        RnVitalsContentSummarySection(data: state.data),
                        RnVitalsPrimaryContentSection(data: state.data),
                        RnVitalsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
