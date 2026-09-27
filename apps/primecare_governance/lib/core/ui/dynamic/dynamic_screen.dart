import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/dynamic_header_section.dart';
import 'sections/dynamic_content_summary_section.dart';
import 'sections/dynamic_primary_content_section.dart';
import 'sections/dynamic_action_bar_section.dart';

class DynamicScreen extends StatelessWidget {
  const DynamicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'dynamic',
      title: 'Dynamic',
      child: Column(
        children: const [
          const DynamicHeaderSection(),
          const DynamicContentSummarySection(),
          const DynamicPrimaryContentSection(),
          const DynamicActionBarSection(),
        ],
      ),
    );
  }
}
