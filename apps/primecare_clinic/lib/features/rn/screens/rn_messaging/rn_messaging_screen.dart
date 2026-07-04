import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/rn_messaging_header_section.dart';
import 'sections/rn_messaging_content_summary_section.dart';
import 'sections/rn_messaging_primary_content_section.dart';
import 'sections/rn_messaging_action_bar_section.dart';

class RnMessagingScreen extends StatelessWidget {
  const RnMessagingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'rn_messaging',
      title: 'Rn Messaging',
      child: Column(
        children: const [
          const RnMessagingHeaderSection(),
          const RnMessagingContentSummarySection(),
          const RnMessagingPrimaryContentSection(),
          const RnMessagingActionBarSection(),
        ],
      ),
    );
  }
}
