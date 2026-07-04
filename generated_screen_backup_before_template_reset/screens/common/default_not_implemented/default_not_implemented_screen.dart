import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/default_not_implemented_header_section.dart';
import 'sections/default_not_implemented_content_summary_section.dart';
import 'sections/default_not_implemented_primary_content_section.dart';
import 'sections/default_not_implemented_action_bar_section.dart';

class DefaultNotImplementedScreen extends StatelessWidget {
  const DefaultNotImplementedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'default_not_implemented',
      title: 'Default Not Implemented',
      child: Column(
        children: const [
          const DefaultNotImplementedHeaderSection(),
          const DefaultNotImplementedContentSummarySection(),
          const DefaultNotImplementedPrimaryContentSection(),
          const DefaultNotImplementedActionBarSection(),
        ],
      ),
    );
  }
}
