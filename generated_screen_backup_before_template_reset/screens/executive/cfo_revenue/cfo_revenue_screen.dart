import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/cfo_revenue_header_section.dart';
import 'sections/cfo_revenue_content_summary_section.dart';
import 'sections/cfo_revenue_primary_content_section.dart';
import 'sections/cfo_revenue_action_bar_section.dart';

class CfoRevenueScreen extends StatelessWidget {
  const CfoRevenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'cfo_revenue',
      title: 'CfoRevenueScreen',
      child: Column(
        children: const [
          const CfoRevenueHeaderSection(),
          const CfoRevenueContentSummarySection(),
          const CfoRevenuePrimaryContentSection(),
          const CfoRevenueActionBarSection(),
        ],
      ),
    );
  }
}
