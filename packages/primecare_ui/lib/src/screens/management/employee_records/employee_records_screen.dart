import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'employee_records_screen_controller.dart';
import 'sections/employee_records_header_section.dart';
import 'sections/employee_records_filter_bar_section.dart';
import 'sections/employee_records_data_table_section.dart';
import 'sections/employee_records_pagination_section.dart';
import 'sections/employee_records_action_bar_section.dart';


class EmployeeRecordsScreen extends ConsumerWidget {
  const EmployeeRecordsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(employee_recordsControllerProvider);

    return Semantics(
      label: 'screen-root',
      container: true,
      child: Scaffold(
        appBar: AppBar(
          title: Semantics(
            label: 'page-title',
            child: const Text('EmployeeRecords'),
          ),
          actions: [
            Semantics(
              label: 'sync-button',
              button: true,
              child: IconButton(
                icon: const Icon(Icons.sync),
                onPressed: () => ref.read(employee_recordsControllerProvider.notifier).syncData(),
              ),
            ),
          ],
        ),
        body: state.isLoading 
            ? Center(key: ValueKey('employee_records_loading'), child: Semantics(label: 'employee_records_loading', child: CircularProgressIndicator()))
            : state.error != null
                ? Center(child: Text('Error: ${state.error}'))
                : SingleChildScrollView(
                    key: const Key('employee_records_screen'),
                    child: Column(
                      children: [
                        EmployeeRecordsHeaderSection(data: state.data),
                        EmployeeRecordsFilterBarSection(data: state.data),
                        EmployeeRecordsDataTableSection(data: state.data),
                        EmployeeRecordsPaginationSection(data: state.data),
                        EmployeeRecordsActionBarSection(data: state.data),

                      ],
                    ),
                  ),
      ),
    );
  }
}
