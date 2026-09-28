import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/clinic_history_logs_header_section.dart';
import 'sections/clinic_history_logs_filter_bar_section.dart';
import 'sections/clinic_history_logs_data_table_section.dart';
import 'sections/clinic_history_logs_pagination_section.dart';
import 'sections/clinic_history_logs_action_bar_section.dart';

class ClinicHistoryLogsScreen extends StatelessWidget {
  const ClinicHistoryLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'clinic_history_logs',
      title: 'Clinic History Logs',
      child: Column(
        children: const [
          const ClinicHistoryLogsHeaderSection(),
          const ClinicHistoryLogsFilterBarSection(),
          const ClinicHistoryLogsDataTableSection(),
          const ClinicHistoryLogsPaginationSection(),
          const ClinicHistoryLogsActionBarSection(),
        ],
      ),
    );
  }
}
