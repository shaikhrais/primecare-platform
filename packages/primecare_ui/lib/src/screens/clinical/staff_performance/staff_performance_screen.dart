import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'staff_performance_screen_controller.dart';
import 'sections/staff_performance_header_section.dart';
import 'sections/staff_performance_form_body_section.dart';
import 'sections/staff_performance_validation_messages_section.dart';
import 'sections/staff_performance_action_bar_section.dart';


class StaffPerformanceScreen extends ConsumerWidget {
  const StaffPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(staff_performanceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('StaffPerformance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(staff_performanceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('staff_performance_loading'), child: Semantics(label: 'staff_performance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('staff_performance_screen'),
                    child: Column(
                      children: [
                        StaffPerformanceHeaderSection(data: state.data),
                        StaffPerformanceFormBodySection(data: state.data),
                        StaffPerformanceValidationMessagesSection(data: state.data),
                        StaffPerformanceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
