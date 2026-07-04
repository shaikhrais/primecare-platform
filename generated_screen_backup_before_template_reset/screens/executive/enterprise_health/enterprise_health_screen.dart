import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/enterprise_health_header_section.dart';
import 'sections/enterprise_health_content_summary_section.dart';
import 'sections/enterprise_health_primary_content_section.dart';
import 'sections/enterprise_health_action_bar_section.dart';

class EnterpriseHealthScreen extends StatelessWidget {
  const EnterpriseHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'enterprise_health',
      title: 'EnterpriseHealthScreen',
      child: Column(
        children: const [
          const EnterpriseHealthHeaderSection(),
          const EnterpriseHealthContentSummarySection(),
          const EnterpriseHealthPrimaryContentSection(),
          const EnterpriseHealthActionBarSection(),
        ],
      ),
    );
  }
}
