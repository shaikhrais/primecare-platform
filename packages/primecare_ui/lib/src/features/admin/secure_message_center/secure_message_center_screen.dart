import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/secure_message_center_header_section.dart';
import 'sections/secure_message_center_content_summary_section.dart';
import 'sections/secure_message_center_primary_content_section.dart';
import 'sections/secure_message_center_action_bar_section.dart';

class SecureMessageCenterScreen extends StatelessWidget {
  const SecureMessageCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'secure_message_center',
      title: 'Secure Message Center',
      child: Column(
        children: const [
          const SecureMessageCenterHeaderSection(),
          const SecureMessageCenterContentSummarySection(),
          const SecureMessageCenterPrimaryContentSection(),
          const SecureMessageCenterActionBarSection(),
        ],
      ),
    );
  }
}
