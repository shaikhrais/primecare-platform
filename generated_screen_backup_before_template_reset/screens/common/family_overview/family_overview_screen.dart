import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/family_overview_header_section.dart';
import 'sections/family_overview_filter_bar_section.dart';
import 'sections/family_overview_data_table_section.dart';
import 'sections/family_overview_pagination_section.dart';
import 'sections/family_overview_action_bar_section.dart';

class FamilyOverviewScreen extends StatelessWidget {
  const FamilyOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'family_overview',
      title: 'FamilyOverviewScreen',
      child: Column(
        children: const [
          const FamilyOverviewHeaderSection(),
          const FamilyOverviewFilterBarSection(),
          const FamilyOverviewDataTableSection(),
          const FamilyOverviewPaginationSection(),
          const FamilyOverviewActionBarSection(),
        ],
      ),
    );
  }
}
