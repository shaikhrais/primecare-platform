import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/daily_operations_header_section.dart';
import 'sections/daily_operations_content_summary_section.dart';
import 'sections/daily_operations_primary_content_section.dart';
import 'sections/daily_operations_action_bar_section.dart';

class DailyOperationsScreen extends StatelessWidget {
  const DailyOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'daily_operations',
      title: 'DailyOperationsScreen',
      child: Column(
        children: const [
          const DailyOperationsHeaderSection(),
          const DailyOperationsContentSummarySection(),
          const DailyOperationsPrimaryContentSection(),
          const DailyOperationsActionBarSection(),
        ],
      ),
    );
  }
}
