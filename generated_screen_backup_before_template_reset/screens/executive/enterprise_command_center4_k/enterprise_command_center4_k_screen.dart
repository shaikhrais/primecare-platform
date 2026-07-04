import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/enterprise_command_center4_k_header_section.dart';
import 'sections/enterprise_command_center4_k_content_summary_section.dart';
import 'sections/enterprise_command_center4_k_primary_content_section.dart';
import 'sections/enterprise_command_center4_k_action_bar_section.dart';

class EnterpriseCommandCenter4KScreen extends StatelessWidget {
  const EnterpriseCommandCenter4KScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'enterprise_command_center4_k',
      title: 'EnterpriseCommandCenter4KScreen',
      child: Column(
        children: const [
          const EnterpriseCommandCenter4KHeaderSection(),
          const EnterpriseCommandCenter4KContentSummarySection(),
          const EnterpriseCommandCenter4KPrimaryContentSection(),
          const EnterpriseCommandCenter4KActionBarSection(),
        ],
      ),
    );
  }
}
