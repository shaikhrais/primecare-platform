import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'hr_director_staff_files_screen_controller.dart';
import 'sections/hr_director_staff_files_header_section.dart';
import 'sections/hr_director_staff_files_content_summary_section.dart';
import 'sections/hr_director_staff_files_primary_content_section.dart';
import 'sections/hr_director_staff_files_action_bar_section.dart';


class HrDirectorStaffFilesScreen extends ConsumerWidget {
  const HrDirectorStaffFilesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hr_director_staff_filesControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('HrDirectorStaffFiles'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(hr_director_staff_filesControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('hr_director_staff_files_loading'), child: Semantics(label: 'hr_director_staff_files_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('hr_director_staff_files_screen'),
                    child: Column(
                      children: [
                        HrDirectorStaffFilesHeaderSection(data: state.data),
                        HrDirectorStaffFilesContentSummarySection(data: state.data),
                        HrDirectorStaffFilesPrimaryContentSection(data: state.data),
                        HrDirectorStaffFilesActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
