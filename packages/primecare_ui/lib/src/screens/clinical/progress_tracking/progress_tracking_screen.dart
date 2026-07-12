import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'progress_tracking_screen_controller.dart';
import 'sections/progress_tracking_header_section.dart';
import 'sections/progress_tracking_content_summary_section.dart';
import 'sections/progress_tracking_primary_content_section.dart';
import 'sections/progress_tracking_action_bar_section.dart';


class ProgressTrackingScreen extends ConsumerWidget {
  const ProgressTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(progress_trackingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ProgressTracking'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(progress_trackingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('progress_tracking_loading'), child: Semantics(label: 'progress_tracking_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('progress_tracking_screen'),
                    child: Column(
                      children: [
                        ProgressTrackingHeaderSection(data: state.data),
                        ProgressTrackingContentSummarySection(data: state.data),
                        ProgressTrackingPrimaryContentSection(data: state.data),
                        ProgressTrackingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
