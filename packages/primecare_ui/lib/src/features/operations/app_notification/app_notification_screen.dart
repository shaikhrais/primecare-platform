import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/app_notification_header_section.dart';
import 'sections/app_notification_content_summary_section.dart';
import 'sections/app_notification_primary_content_section.dart';
import 'sections/app_notification_action_bar_section.dart';

class AppNotificationScreen extends StatelessWidget {
  const AppNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'app_notification',
      title: 'App Notification',
      child: Column(
        children: const [
          const AppNotificationHeaderSection(),
          const AppNotificationContentSummarySection(),
          const AppNotificationPrimaryContentSection(),
          const AppNotificationActionBarSection(),
        ],
      ),
    );
  }
}
