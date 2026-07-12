import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'vitals_tracking_screen_controller.dart';
import 'sections/vitals_tracking_header_section.dart';
import 'sections/vitals_tracking_content_summary_section.dart';
import 'sections/vitals_tracking_primary_content_section.dart';
import 'sections/vitals_tracking_action_bar_section.dart';


class VitalsTrackingScreen extends ConsumerWidget {
  const VitalsTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(vitals_trackingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('VitalsTracking'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(vitals_trackingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('vitals_tracking_loading'), child: Semantics(label: 'vitals_tracking_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('vitals_tracking_screen'),
                    child: Column(
                      children: [
                        VitalsTrackingHeaderSection(data: state.data),
                        VitalsTrackingContentSummarySection(data: state.data),
                        VitalsTrackingPrimaryContentSection(data: state.data),
                        VitalsTrackingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
