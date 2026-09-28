import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cto_system_health_header_section.dart';
import 'sections/cto_system_health_content_summary_section.dart';
import 'sections/cto_system_health_primary_content_section.dart';
import 'sections/cto_system_health_action_bar_section.dart';

class CtoSystemHealthScreen extends StatelessWidget {
  const CtoSystemHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cto_system_health',
      title: 'Cto System Health',
      child: Column(
        children: const [
          const CtoSystemHealthHeaderSection(),
          const CtoSystemHealthContentSummarySection(),
          const CtoSystemHealthPrimaryContentSection(),
          const CtoSystemHealthActionBarSection(),
        ],
      ),
    );
  }
}
