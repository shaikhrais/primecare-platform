import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/refund_management_header_section.dart';
import 'sections/refund_management_content_summary_section.dart';
import 'sections/refund_management_primary_content_section.dart';
import 'sections/refund_management_action_bar_section.dart';

class RefundManagementScreen extends StatelessWidget {
  const RefundManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'refund_management',
      title: 'RefundManagementScreen',
      child: Column(
        children: const [
          const RefundManagementHeaderSection(),
          const RefundManagementContentSummarySection(),
          const RefundManagementPrimaryContentSection(),
          const RefundManagementActionBarSection(),
        ],
      ),
    );
  }
}
