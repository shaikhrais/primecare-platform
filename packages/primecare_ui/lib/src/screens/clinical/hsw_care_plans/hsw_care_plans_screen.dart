import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hsw_care_plans_screen_controller.dart';
import 'sections/hsw_care_plans_header_section.dart';
import 'sections/hsw_care_plans_content_summary_section.dart';
import 'sections/hsw_care_plans_primary_content_section.dart';
import 'sections/hsw_care_plans_action_bar_section.dart';


class HswCarePlansScreen extends ConsumerWidget {
  const HswCarePlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hsw_care_plansControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HswCarePlans'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hsw_care_plansControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hsw_care_plans_loading'), child: Semantics(label: 'hsw_care_plans_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hsw_care_plans_screen'),
                    child: Column(
                      children: [
                        HswCarePlansHeaderSection(data: state.data),
                        HswCarePlansContentSummarySection(data: state.data),
                        HswCarePlansPrimaryContentSection(data: state.data),
                        HswCarePlansActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
