import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/screen_not_implemented_header_section.dart';
import 'sections/screen_not_implemented_content_summary_section.dart';
import 'sections/screen_not_implemented_primary_content_section.dart';
import 'sections/screen_not_implemented_action_bar_section.dart';

class ScreenNotImplementedScreen extends StatelessWidget {
  const ScreenNotImplementedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'screen_not_implemented',
      title: 'Screen Not Implemented',
      child: Column(
        children: const [
          const ScreenNotImplementedHeaderSection(),
          const ScreenNotImplementedContentSummarySection(),
          const ScreenNotImplementedPrimaryContentSection(),
          const ScreenNotImplementedActionBarSection(),
        ],
      ),
    );
  }
}
