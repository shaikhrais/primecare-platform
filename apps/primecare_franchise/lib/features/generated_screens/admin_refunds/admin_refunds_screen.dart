import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/admin_refunds_header_section.dart';
import 'sections/admin_refunds_content_summary_section.dart';
import 'sections/admin_refunds_primary_content_section.dart';
import 'sections/admin_refunds_action_bar_section.dart';

class AdminRefundsScreen extends StatelessWidget {
  const AdminRefundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'admin_refunds',
      title: 'Admin Refunds',
      child: Column(
        children: const [
          const AdminRefundsHeaderSection(),
          const AdminRefundsContentSummarySection(),
          const AdminRefundsPrimaryContentSection(),
          const AdminRefundsActionBarSection(),
        ],
      ),
    );
  }
}
