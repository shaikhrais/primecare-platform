import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/head_of_marketing_performance_reports_header_section.dart';
import 'sections/head_of_marketing_performance_reports_form_body_section.dart';
import 'sections/head_of_marketing_performance_reports_validation_messages_section.dart';
import 'sections/head_of_marketing_performance_reports_action_bar_section.dart';

class HeadOfMarketingPerformanceReportsScreen extends StatelessWidget {
  const HeadOfMarketingPerformanceReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'head_of_marketing_performance_reports',
      title: 'Head Of Marketing Performance Reports',
      child: Column(
        children: const [
          const HeadOfMarketingPerformanceReportsHeaderSection(),
          const HeadOfMarketingPerformanceReportsFormBodySection(),
          const HeadOfMarketingPerformanceReportsValidationMessagesSection(),
          const HeadOfMarketingPerformanceReportsActionBarSection(),
        ],
      ),
    );
  }
}
