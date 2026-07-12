import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'api_monitoring_screen_controller.dart';
import 'sections/api_monitoring_header_section.dart';
import 'sections/api_monitoring_content_summary_section.dart';
import 'sections/api_monitoring_primary_content_section.dart';
import 'sections/api_monitoring_action_bar_section.dart';


class ApiMonitoringScreen extends ConsumerWidget {
  const ApiMonitoringScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(api_monitoringControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('ApiMonitoring'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(api_monitoringControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('api_monitoring_loading'), child: Semantics(label: 'api_monitoring_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('api_monitoring_screen'),
                    child: Column(
                      children: [
                        ApiMonitoringHeaderSection(data: state.data),
                        ApiMonitoringContentSummarySection(data: state.data),
                        ApiMonitoringPrimaryContentSection(data: state.data),
                        ApiMonitoringActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
