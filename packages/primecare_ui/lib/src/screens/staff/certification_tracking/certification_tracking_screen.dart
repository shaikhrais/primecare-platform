import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'certification_tracking_screen_controller.dart';
import 'sections/certification_tracking_header_section.dart';
import 'sections/certification_tracking_content_summary_section.dart';
import 'sections/certification_tracking_primary_content_section.dart';
import 'sections/certification_tracking_action_bar_section.dart';


class CertificationTrackingScreen extends ConsumerWidget {
  const CertificationTrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(certification_trackingControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CertificationTracking'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(certification_trackingControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('certification_tracking_loading'), child: Semantics(label: 'certification_tracking_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('certification_tracking_screen'),
                    child: Column(
                      children: [
                        CertificationTrackingHeaderSection(data: state.data),
                        CertificationTrackingContentSummarySection(data: state.data),
                        CertificationTrackingPrimaryContentSection(data: state.data),
                        CertificationTrackingActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
