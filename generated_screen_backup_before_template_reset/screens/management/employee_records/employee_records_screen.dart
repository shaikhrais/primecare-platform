import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/employee_records_header_section.dart';
import 'sections/employee_records_filter_bar_section.dart';
import 'sections/employee_records_data_table_section.dart';
import 'sections/employee_records_pagination_section.dart';
import 'sections/employee_records_action_bar_section.dart';

class EmployeeRecordsScreen extends StatelessWidget {
  const EmployeeRecordsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'employee_records',
      title: 'EmployeeRecordsScreen',
      child: Column(
        children: const [
          const EmployeeRecordsHeaderSection(),
          const EmployeeRecordsFilterBarSection(),
          const EmployeeRecordsDataTableSection(),
          const EmployeeRecordsPaginationSection(),
          const EmployeeRecordsActionBarSection(),
        ],
      ),
    );
  }
}
