import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/controlled_substance_log_header_section.dart';
import 'sections/controlled_substance_log_filter_bar_section.dart';
import 'sections/controlled_substance_log_data_table_section.dart';
import 'sections/controlled_substance_log_pagination_section.dart';
import 'sections/controlled_substance_log_action_bar_section.dart';

class ControlledSubstanceLogScreen extends StatelessWidget {
  const ControlledSubstanceLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'controlled_substance_log',
      title: 'Controlled Substance Log',
      child: Column(
        children: const [
          const ControlledSubstanceLogHeaderSection(),
          const ControlledSubstanceLogFilterBarSection(),
          const ControlledSubstanceLogDataTableSection(),
          const ControlledSubstanceLogPaginationSection(),
          const ControlledSubstanceLogActionBarSection(),
        ],
      ),
    );
  }
}
