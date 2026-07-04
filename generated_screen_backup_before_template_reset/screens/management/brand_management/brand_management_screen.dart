import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/brand_management_header_section.dart';
import 'sections/brand_management_content_summary_section.dart';
import 'sections/brand_management_primary_content_section.dart';
import 'sections/brand_management_action_bar_section.dart';

class BrandManagementScreen extends StatelessWidget {
  const BrandManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'brand_management',
      title: 'BrandManagementScreen',
      child: Column(
        children: const [
          const BrandManagementHeaderSection(),
          const BrandManagementContentSummarySection(),
          const BrandManagementPrimaryContentSection(),
          const BrandManagementActionBarSection(),
        ],
      ),
    );
  }
}
