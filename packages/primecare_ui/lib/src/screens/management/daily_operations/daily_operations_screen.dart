import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'daily_operations_screen_controller.dart';
import 'sections/daily_operations_header_section.dart';
import 'sections/daily_operations_content_summary_section.dart';
import 'sections/daily_operations_primary_content_section.dart';
import 'sections/daily_operations_action_bar_section.dart';


class DailyOperationsScreen extends ConsumerWidget {
  const DailyOperationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(daily_operationsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('DailyOperations'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(daily_operationsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('daily_operations_loading'), child: Semantics(label: 'daily_operations_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('daily_operations_screen'),
                    child: Column(
                      children: [
                        DailyOperationsHeaderSection(data: state.data),
                        DailyOperationsContentSummarySection(data: state.data),
                        DailyOperationsPrimaryContentSection(data: state.data),
                        DailyOperationsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
