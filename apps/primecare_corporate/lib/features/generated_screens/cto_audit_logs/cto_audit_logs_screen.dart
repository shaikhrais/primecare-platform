import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_audit_logs_header_section.dart';
import 'sections/cto_audit_logs_filter_bar_section.dart';
import 'sections/cto_audit_logs_data_table_section.dart';
import 'sections/cto_audit_logs_pagination_section.dart';
import 'sections/cto_audit_logs_action_bar_section.dart';

class CtoAuditLogsScreen extends StatelessWidget {
  const CtoAuditLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_audit_logs',
      title: 'Cto Audit Logs',
      child: Column(
        children: const [
          const CtoAuditLogsHeaderSection(),
          const CtoAuditLogsFilterBarSection(),
          const CtoAuditLogsDataTableSection(),
          const CtoAuditLogsPaginationSection(),
          const CtoAuditLogsActionBarSection(),
        ],
      ),
    );
  }
}
