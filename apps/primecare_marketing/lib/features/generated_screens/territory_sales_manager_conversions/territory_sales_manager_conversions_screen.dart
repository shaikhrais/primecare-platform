import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_manager_conversions_header_section.dart';
import 'sections/territory_sales_manager_conversions_content_summary_section.dart';
import 'sections/territory_sales_manager_conversions_primary_content_section.dart';
import 'sections/territory_sales_manager_conversions_action_bar_section.dart';

class TerritorySalesManagerConversionsScreen extends StatelessWidget {
  const TerritorySalesManagerConversionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_manager_conversions',
      title: 'Territory Sales Manager Conversions',
      child: Column(
        children: const [
          const TerritorySalesManagerConversionsHeaderSection(),
          const TerritorySalesManagerConversionsContentSummarySection(),
          const TerritorySalesManagerConversionsPrimaryContentSection(),
          const TerritorySalesManagerConversionsActionBarSection(),
        ],
      ),
    );
  }
}
