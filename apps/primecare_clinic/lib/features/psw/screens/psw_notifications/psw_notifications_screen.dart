import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_notifications_header_section.dart';
import 'sections/psw_notifications_content_summary_section.dart';
import 'sections/psw_notifications_primary_content_section.dart';
import 'sections/psw_notifications_action_bar_section.dart';

class PswNotificationsScreen extends StatelessWidget {
  const PswNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_notifications',
      title: 'Psw Notifications',
      child: Column(
        children: const [
          const PswNotificationsHeaderSection(),
          const PswNotificationsContentSummarySection(),
          const PswNotificationsPrimaryContentSection(),
          const PswNotificationsActionBarSection(),
        ],
      ),
    );
  }
}
