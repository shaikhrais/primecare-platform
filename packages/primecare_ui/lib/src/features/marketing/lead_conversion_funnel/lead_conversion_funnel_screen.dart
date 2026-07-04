import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/lead_conversion_funnel_header_section.dart';
import 'sections/lead_conversion_funnel_content_summary_section.dart';
import 'sections/lead_conversion_funnel_primary_content_section.dart';
import 'sections/lead_conversion_funnel_action_bar_section.dart';

class LeadConversionFunnelScreen extends StatelessWidget {
  const LeadConversionFunnelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'lead_conversion_funnel',
      title: 'Lead Conversion Funnel',
      child: Column(
        children: const [
          const LeadConversionFunnelHeaderSection(),
          const LeadConversionFunnelContentSummarySection(),
          const LeadConversionFunnelPrimaryContentSection(),
          const LeadConversionFunnelActionBarSection(),
        ],
      ),
    );
  }
}
