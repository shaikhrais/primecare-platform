import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/coo_scheduling_health_header_section.dart';
import 'sections/coo_scheduling_health_content_summary_section.dart';
import 'sections/coo_scheduling_health_primary_content_section.dart';
import 'sections/coo_scheduling_health_action_bar_section.dart';

class CooSchedulingHealthScreen extends StatelessWidget {
  const CooSchedulingHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'coo_scheduling_health',
      title: 'CooSchedulingHealthScreen',
      child: Column(
        children: const [
          const CooSchedulingHealthHeaderSection(),
          const CooSchedulingHealthContentSummarySection(),
          const CooSchedulingHealthPrimaryContentSection(),
          const CooSchedulingHealthActionBarSection(),
        ],
      ),
    );
  }
}
