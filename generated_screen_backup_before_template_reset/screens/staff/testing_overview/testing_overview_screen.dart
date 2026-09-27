import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/testing_overview_header_section.dart';
import 'sections/testing_overview_filter_bar_section.dart';
import 'sections/testing_overview_data_table_section.dart';
import 'sections/testing_overview_pagination_section.dart';
import 'sections/testing_overview_action_bar_section.dart';

class TestingOverviewScreen extends StatelessWidget {
  const TestingOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'testing_overview',
      title: 'TestingOverviewScreen',
      child: Column(
        children: const [
          const TestingOverviewHeaderSection(),
          const TestingOverviewFilterBarSection(),
          const TestingOverviewDataTableSection(),
          const TestingOverviewPaginationSection(),
          const TestingOverviewActionBarSection(),
        ],
      ),
    );
  }
}
