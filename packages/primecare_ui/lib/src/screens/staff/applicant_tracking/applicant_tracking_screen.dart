import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'applicant_tracking_screen_controller.dart';
import 'sections/applicant_tracking_header_section.dart';
import 'sections/applicant_tracking_content_summary_section.dart';
import 'sections/applicant_tracking_primary_content_section.dart';
import 'sections/applicant_tracking_action_bar_section.dart';


class ApplicantTrackingScreen extends ConsumerWidget {
  const ApplicantTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(applicant_trackingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ApplicantTracking'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(applicant_trackingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('applicant_tracking_loading'), child: Semantics(label: 'applicant_tracking_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('applicant_tracking_screen'),
                    child: Column(
                      children: [
                        ApplicantTrackingHeaderSection(data: state.data),
                        ApplicantTrackingContentSummarySection(data: state.data),
                        ApplicantTrackingPrimaryContentSection(data: state.data),
                        ApplicantTrackingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
