import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_mapping_header_section.dart';
import 'sections/territory_sales_mapping_content_summary_section.dart';
import 'sections/territory_sales_mapping_primary_content_section.dart';
import 'sections/territory_sales_mapping_action_bar_section.dart';

class TerritorySalesMappingScreen extends StatelessWidget {
  const TerritorySalesMappingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_mapping',
      title: 'Territory Sales Mapping',
      child: Column(
        children: const [
          const TerritorySalesMappingHeaderSection(),
          const TerritorySalesMappingContentSummarySection(),
          const TerritorySalesMappingPrimaryContentSection(),
          const TerritorySalesMappingActionBarSection(),
        ],
      ),
    );
  }
}
