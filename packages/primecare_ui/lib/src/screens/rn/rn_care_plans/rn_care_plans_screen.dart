import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'rn_care_plans_screen_controller.dart';
import 'sections/rn_care_plans_header_section.dart';
import 'sections/rn_care_plans_content_summary_section.dart';
import 'sections/rn_care_plans_primary_content_section.dart';
import 'sections/rn_care_plans_action_bar_section.dart';


class RnCarePlansScreen extends ConsumerWidget {
  const RnCarePlansScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rn_care_plansControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('RnCarePlans'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(rn_care_plansControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('rn_care_plans_loading'), child: Semantics(label: 'rn_care_plans_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('rn_care_plans_screen'),
                    child: Column(
                      children: [
                        RnCarePlansHeaderSection(data: state.data),
                        RnCarePlansContentSummarySection(data: state.data),
                        RnCarePlansPrimaryContentSection(data: state.data),
                        RnCarePlansActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
