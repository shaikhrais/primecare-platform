import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_system_logs_header_section.dart';
import 'sections/psw_system_logs_filter_bar_section.dart';
import 'sections/psw_system_logs_data_table_section.dart';
import 'sections/psw_system_logs_pagination_section.dart';
import 'sections/psw_system_logs_action_bar_section.dart';

class PswSystemLogsScreen extends StatelessWidget {
  const PswSystemLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_system_logs',
      title: 'Psw System Logs',
      child: Column(
        children: const [
          const PswSystemLogsHeaderSection(),
          const PswSystemLogsFilterBarSection(),
          const PswSystemLogsDataTableSection(),
          const PswSystemLogsPaginationSection(),
          const PswSystemLogsActionBarSection(),
        ],
      ),
    );
  }
}
