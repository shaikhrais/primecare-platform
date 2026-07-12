import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'branch_performance_screen_controller.dart';
import 'sections/branch_performance_header_section.dart';
import 'sections/branch_performance_form_body_section.dart';
import 'sections/branch_performance_validation_messages_section.dart';
import 'sections/branch_performance_action_bar_section.dart';


class BranchPerformanceScreen extends ConsumerWidget {
  const BranchPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(branch_performanceControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('BranchPerformance'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(branch_performanceControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('branch_performance_loading'), child: Semantics(label: 'branch_performance_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('branch_performance_screen'),
                    child: Column(
                      children: [
                        BranchPerformanceHeaderSection(data: state.data),
                        BranchPerformanceFormBodySection(data: state.data),
                        BranchPerformanceValidationMessagesSection(data: state.data),
                        BranchPerformanceActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
