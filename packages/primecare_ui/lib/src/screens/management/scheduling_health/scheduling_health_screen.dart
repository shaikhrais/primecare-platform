import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'scheduling_health_screen_controller.dart';
import 'sections/scheduling_health_header_section.dart';
import 'sections/scheduling_health_content_summary_section.dart';
import 'sections/scheduling_health_primary_content_section.dart';
import 'sections/scheduling_health_action_bar_section.dart';


class SchedulingHealthScreen extends ConsumerWidget {
  const SchedulingHealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduling_healthControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('SchedulingHealth'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(scheduling_healthControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('scheduling_health_loading'), child: Semantics(label: 'scheduling_health_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('scheduling_health_screen'),
                    child: Column(
                      children: [
                        SchedulingHealthHeaderSection(data: state.data),
                        SchedulingHealthContentSummarySection(data: state.data),
                        SchedulingHealthPrimaryContentSection(data: state.data),
                        SchedulingHealthActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
