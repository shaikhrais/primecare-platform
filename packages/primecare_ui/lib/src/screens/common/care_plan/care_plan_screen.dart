import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'care_plan_screen_controller.dart';
import 'sections/care_plan_header_section.dart';
import 'sections/care_plan_content_summary_section.dart';
import 'sections/care_plan_primary_content_section.dart';
import 'sections/care_plan_action_bar_section.dart';


class CarePlanScreen extends ConsumerWidget {
  const CarePlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(care_planControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('CarePlan'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(care_planControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('care_plan_loading'), child: Semantics(label: 'care_plan_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('care_plan_screen'),
                    child: Column(
                      children: [
                        CarePlanHeaderSection(data: state.data),
                        CarePlanContentSummarySection(data: state.data),
                        CarePlanPrimaryContentSection(data: state.data),
                        CarePlanActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
