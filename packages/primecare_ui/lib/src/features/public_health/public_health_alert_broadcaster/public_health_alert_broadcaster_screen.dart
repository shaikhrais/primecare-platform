import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/public_health_alert_broadcaster_header_section.dart';
import 'sections/public_health_alert_broadcaster_content_summary_section.dart';
import 'sections/public_health_alert_broadcaster_primary_content_section.dart';
import 'sections/public_health_alert_broadcaster_action_bar_section.dart';

class PublicHealthAlertBroadcasterScreen extends StatelessWidget {
  const PublicHealthAlertBroadcasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'public_health_alert_broadcaster',
      title: 'Public Health Alert Broadcaster',
      child: Column(
        children: const [
          const PublicHealthAlertBroadcasterHeaderSection(),
          const PublicHealthAlertBroadcasterContentSummarySection(),
          const PublicHealthAlertBroadcasterPrimaryContentSection(),
          const PublicHealthAlertBroadcasterActionBarSection(),
        ],
      ),
    );
  }
}
