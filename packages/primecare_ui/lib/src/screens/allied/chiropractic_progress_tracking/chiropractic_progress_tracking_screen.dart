import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'chiropractic_progress_tracking_screen_controller.dart';
import 'sections/chiropractic_progress_tracking_header_section.dart';
import 'sections/chiropractic_progress_tracking_content_summary_section.dart';
import 'sections/chiropractic_progress_tracking_primary_content_section.dart';
import 'sections/chiropractic_progress_tracking_action_bar_section.dart';


class ChiropracticProgressTrackingScreen extends ConsumerWidget {
  const ChiropracticProgressTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(chiropractic_progress_trackingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ChiropracticProgressTracking'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(chiropractic_progress_trackingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('chiropractic_progress_tracking_loading'), child: Semantics(label: 'chiropractic_progress_tracking_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('chiropractic_progress_tracking_screen'),
                    child: Column(
                      children: [
                        ChiropracticProgressTrackingHeaderSection(data: state.data),
                        ChiropracticProgressTrackingContentSummarySection(data: state.data),
                        ChiropracticProgressTrackingPrimaryContentSection(data: state.data),
                        ChiropracticProgressTrackingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
