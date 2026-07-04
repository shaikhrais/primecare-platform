import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/system_health_header_section.dart';
import 'sections/system_health_content_summary_section.dart';
import 'sections/system_health_primary_content_section.dart';
import 'sections/system_health_action_bar_section.dart';

class SystemHealthScreen extends StatelessWidget {
  const SystemHealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'system_health',
      title: 'SystemHealthScreen',
      child: Column(
        children: const [
          const SystemHealthHeaderSection(),
          const SystemHealthContentSummarySection(),
          const SystemHealthPrimaryContentSection(),
          const SystemHealthActionBarSection(),
        ],
      ),
    );
  }
}
