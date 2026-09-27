import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/data_privacy_monitor_header_section.dart';
import 'sections/data_privacy_monitor_content_summary_section.dart';
import 'sections/data_privacy_monitor_primary_content_section.dart';
import 'sections/data_privacy_monitor_action_bar_section.dart';

class DataPrivacyMonitorScreen extends StatelessWidget {
  const DataPrivacyMonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'data_privacy_monitor',
      title: 'Data Privacy Monitor',
      child: Column(
        children: const [
          const DataPrivacyMonitorHeaderSection(),
          const DataPrivacyMonitorContentSummarySection(),
          const DataPrivacyMonitorPrimaryContentSection(),
          const DataPrivacyMonitorActionBarSection(),
        ],
      ),
    );
  }
}
