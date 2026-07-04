import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/vulnerable_population_registry_header_section.dart';
import 'sections/vulnerable_population_registry_filter_bar_section.dart';
import 'sections/vulnerable_population_registry_data_table_section.dart';
import 'sections/vulnerable_population_registry_pagination_section.dart';
import 'sections/vulnerable_population_registry_action_bar_section.dart';

class VulnerablePopulationRegistryScreen extends StatelessWidget {
  const VulnerablePopulationRegistryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'vulnerable_population_registry',
      title: 'Vulnerable Population Registry',
      child: Column(
        children: const [
          const VulnerablePopulationRegistryHeaderSection(),
          const VulnerablePopulationRegistryFilterBarSection(),
          const VulnerablePopulationRegistryDataTableSection(),
          const VulnerablePopulationRegistryPaginationSection(),
          const VulnerablePopulationRegistryActionBarSection(),
        ],
      ),
    );
  }
}
