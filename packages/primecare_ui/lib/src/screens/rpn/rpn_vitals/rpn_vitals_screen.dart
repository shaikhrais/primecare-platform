import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rpn_vitals_screen_controller.dart';
import 'sections/rpn_vitals_header_section.dart';
import 'sections/rpn_vitals_content_summary_section.dart';
import 'sections/rpn_vitals_primary_content_section.dart';
import 'sections/rpn_vitals_action_bar_section.dart';


class RpnVitalsScreen extends ConsumerWidget {
  const RpnVitalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpn_vitalsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RpnVitals'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rpn_vitalsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rpn_vitals_loading'), child: Semantics(label: 'rpn_vitals_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rpn_vitals_screen'),
                    child: Column(
                      children: [
                        RpnVitalsHeaderSection(data: state.data),
                        RpnVitalsContentSummarySection(data: state.data),
                        RpnVitalsPrimaryContentSection(data: state.data),
                        RpnVitalsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
