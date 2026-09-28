import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/audit_log_header_section.dart';
import 'sections/audit_log_filter_bar_section.dart';
import 'sections/audit_log_data_table_section.dart';
import 'sections/audit_log_pagination_section.dart';
import 'sections/audit_log_action_bar_section.dart';

class AuditLogScreen extends StatelessWidget {
  const AuditLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'audit_log',
      title: 'Audit Log',
      child: Column(
        children: const [
          const AuditLogHeaderSection(),
          const AuditLogFilterBarSection(),
          const AuditLogDataTableSection(),
          const AuditLogPaginationSection(),
          const AuditLogActionBarSection(),
        ],
      ),
    );
  }
}
