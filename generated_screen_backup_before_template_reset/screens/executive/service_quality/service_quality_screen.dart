import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/service_quality_header_section.dart';
import 'sections/service_quality_content_summary_section.dart';
import 'sections/service_quality_primary_content_section.dart';
import 'sections/service_quality_action_bar_section.dart';

class ServiceQualityScreen extends StatelessWidget {
  const ServiceQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'service_quality',
      title: 'ServiceQualityScreen',
      child: Column(
        children: const [
          const ServiceQualityHeaderSection(),
          const ServiceQualityContentSummarySection(),
          const ServiceQualityPrimaryContentSection(),
          const ServiceQualityActionBarSection(),
        ],
      ),
    );
  }
}
