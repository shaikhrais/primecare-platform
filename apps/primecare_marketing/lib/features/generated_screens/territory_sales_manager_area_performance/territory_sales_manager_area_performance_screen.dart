import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_sales_manager_area_performance_header_section.dart';
import 'sections/territory_sales_manager_area_performance_form_body_section.dart';
import 'sections/territory_sales_manager_area_performance_validation_messages_section.dart';
import 'sections/territory_sales_manager_area_performance_action_bar_section.dart';

class TerritorySalesManagerAreaPerformanceScreen extends StatelessWidget {
  const TerritorySalesManagerAreaPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_sales_manager_area_performance',
      title: 'Territory Sales Manager Area Performance',
      child: Column(
        children: const [
          const TerritorySalesManagerAreaPerformanceHeaderSection(),
          const TerritorySalesManagerAreaPerformanceFormBodySection(),
          const TerritorySalesManagerAreaPerformanceValidationMessagesSection(),
          const TerritorySalesManagerAreaPerformanceActionBarSection(),
        ],
      ),
    );
  }
}
