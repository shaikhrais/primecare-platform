import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_hiring_interviews_screen_controller.dart';
import 'sections/hr_hiring_interviews_header_section.dart';
import 'sections/hr_hiring_interviews_filter_bar_section.dart';
import 'sections/hr_hiring_interviews_data_table_section.dart';
import 'sections/hr_hiring_interviews_pagination_section.dart';
import 'sections/hr_hiring_interviews_action_bar_section.dart';


class HrHiringInterviewsScreen extends ConsumerWidget {
  const HrHiringInterviewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_hiring_interviewsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrHiringInterviews'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_hiring_interviewsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_hiring_interviews_loading'), child: Semantics(label: 'hr_hiring_interviews_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_hiring_interviews_screen'),
                    child: Column(
                      children: [
                        HrHiringInterviewsHeaderSection(data: state.data),
                        HrHiringInterviewsFilterBarSection(data: state.data),
                        HrHiringInterviewsDataTableSection(data: state.data),
                        HrHiringInterviewsPaginationSection(data: state.data),
                        HrHiringInterviewsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
