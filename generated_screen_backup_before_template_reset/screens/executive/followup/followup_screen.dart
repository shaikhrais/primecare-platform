import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/followup_header_section.dart';
import 'sections/followup_content_summary_section.dart';
import 'sections/followup_primary_content_section.dart';
import 'sections/followup_action_bar_section.dart';

class FollowupScreen extends StatelessWidget {
  const FollowupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'followup',
      title: 'FollowupScreen',
      child: Column(
        children: const [
          const FollowupHeaderSection(),
          const FollowupContentSummarySection(),
          const FollowupPrimaryContentSection(),
          const FollowupActionBarSection(),
        ],
      ),
    );
  }
}
