import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/operations_manager_service_quality_header_section.dart';
import 'sections/operations_manager_service_quality_content_summary_section.dart';
import 'sections/operations_manager_service_quality_primary_content_section.dart';
import 'sections/operations_manager_service_quality_action_bar_section.dart';

class OperationsManagerServiceQualityScreen extends StatelessWidget {
  const OperationsManagerServiceQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'operations_manager_service_quality',
      title: 'Operations Manager Service Quality',
      child: Column(
        children: const [
          const OperationsManagerServiceQualityHeaderSection(),
          const OperationsManagerServiceQualityContentSummarySection(),
          const OperationsManagerServiceQualityPrimaryContentSection(),
          const OperationsManagerServiceQualityActionBarSection(),
        ],
      ),
    );
  }
}
