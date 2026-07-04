import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/site_readiness_header_section.dart';
import 'sections/site_readiness_content_summary_section.dart';
import 'sections/site_readiness_primary_content_section.dart';
import 'sections/site_readiness_action_bar_section.dart';

class SiteReadinessScreen extends StatelessWidget {
  const SiteReadinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'site_readiness',
      title: 'Site Readiness',
      child: Column(
        children: const [
          const SiteReadinessHeaderSection(),
          const SiteReadinessContentSummarySection(),
          const SiteReadinessPrimaryContentSection(),
          const SiteReadinessActionBarSection(),
        ],
      ),
    );
  }
}
