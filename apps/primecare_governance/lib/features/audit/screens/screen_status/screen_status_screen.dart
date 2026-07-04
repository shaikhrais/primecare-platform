import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/screen_status_header_section.dart';
import 'sections/screen_status_content_summary_section.dart';
import 'sections/screen_status_primary_content_section.dart';
import 'sections/screen_status_action_bar_section.dart';

class ScreenStatusScreen extends StatelessWidget {
  const ScreenStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'screen_status',
      title: 'Screen Status',
      child: Column(
        children: const [
          const ScreenStatusHeaderSection(),
          const ScreenStatusContentSummarySection(),
          const ScreenStatusPrimaryContentSection(),
          const ScreenStatusActionBarSection(),
        ],
      ),
    );
  }
}
