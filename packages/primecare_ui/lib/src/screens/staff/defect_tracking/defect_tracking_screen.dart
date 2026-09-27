import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'defect_tracking_screen_controller.dart';
import 'sections/defect_tracking_header_section.dart';
import 'sections/defect_tracking_content_summary_section.dart';
import 'sections/defect_tracking_primary_content_section.dart';
import 'sections/defect_tracking_action_bar_section.dart';


class DefectTrackingScreen extends ConsumerWidget {
  const DefectTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(defect_trackingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('DefectTracking'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(defect_trackingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('defect_tracking_loading'), child: Semantics(label: 'defect_tracking_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('defect_tracking_screen'),
                    child: Column(
                      children: [
                        DefectTrackingHeaderSection(data: state.data),
                        DefectTrackingContentSummarySection(data: state.data),
                        DefectTrackingPrimaryContentSection(data: state.data),
                        DefectTrackingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
