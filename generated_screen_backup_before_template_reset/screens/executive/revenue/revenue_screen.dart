import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/revenue_header_section.dart';
import 'sections/revenue_content_summary_section.dart';
import 'sections/revenue_primary_content_section.dart';
import 'sections/revenue_action_bar_section.dart';

class RevenueScreen extends StatelessWidget {
  const RevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'revenue',
      title: 'RevenueScreen',
      child: Column(
        children: const [
          const RevenueHeaderSection(),
          const RevenueContentSummarySection(),
          const RevenuePrimaryContentSection(),
          const RevenueActionBarSection(),
        ],
      ),
    );
  }
}
