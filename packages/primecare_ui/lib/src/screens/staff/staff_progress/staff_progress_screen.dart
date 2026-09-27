import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'staff_progress_screen_controller.dart';
import 'sections/staff_progress_header_section.dart';
import 'sections/staff_progress_content_summary_section.dart';
import 'sections/staff_progress_primary_content_section.dart';
import 'sections/staff_progress_action_bar_section.dart';


class StaffProgressScreen extends ConsumerWidget {
  const StaffProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(staff_progressControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('StaffProgress'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(staff_progressControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('staff_progress_loading'), child: Semantics(label: 'staff_progress_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('staff_progress_screen'),
                    child: Column(
                      children: [
                        StaffProgressHeaderSection(data: state.data),
                        StaffProgressContentSummarySection(data: state.data),
                        StaffProgressPrimaryContentSection(data: state.data),
                        StaffProgressActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
