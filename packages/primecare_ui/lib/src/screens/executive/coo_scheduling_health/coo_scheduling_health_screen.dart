import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'coo_scheduling_health_screen_controller.dart';
import 'sections/coo_scheduling_health_header_section.dart';
import 'sections/coo_scheduling_health_content_summary_section.dart';
import 'sections/coo_scheduling_health_primary_content_section.dart';
import 'sections/coo_scheduling_health_action_bar_section.dart';


class CooSchedulingHealthScreen extends ConsumerWidget {
  const CooSchedulingHealthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coo_scheduling_healthControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CooSchedulingHealth'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(coo_scheduling_healthControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('coo_scheduling_health_loading'), child: Semantics(label: 'coo_scheduling_health_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('coo_scheduling_health_screen'),
                    child: Column(
                      children: [
                        CooSchedulingHealthHeaderSection(data: state.data),
                        CooSchedulingHealthContentSummarySection(data: state.data),
                        CooSchedulingHealthPrimaryContentSection(data: state.data),
                        CooSchedulingHealthActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
