import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/territory_expansion_manager_forecast_header_section.dart';
import 'sections/territory_expansion_manager_forecast_content_summary_section.dart';
import 'sections/territory_expansion_manager_forecast_primary_content_section.dart';
import 'sections/territory_expansion_manager_forecast_action_bar_section.dart';

class TerritoryExpansionManagerForecastScreen extends StatelessWidget {
  const TerritoryExpansionManagerForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'territory_expansion_manager_forecast',
      title: 'Territory Expansion Manager Forecast',
      child: Column(
        children: const [
          const TerritoryExpansionManagerForecastHeaderSection(),
          const TerritoryExpansionManagerForecastContentSummarySection(),
          const TerritoryExpansionManagerForecastPrimaryContentSection(),
          const TerritoryExpansionManagerForecastActionBarSection(),
        ],
      ),
    );
  }
}
