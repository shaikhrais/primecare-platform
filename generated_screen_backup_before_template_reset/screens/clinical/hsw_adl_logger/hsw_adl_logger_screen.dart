import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/hsw_adl_logger_header_section.dart';
import 'sections/hsw_adl_logger_filter_bar_section.dart';
import 'sections/hsw_adl_logger_data_table_section.dart';
import 'sections/hsw_adl_logger_pagination_section.dart';
import 'sections/hsw_adl_logger_action_bar_section.dart';

class HswAdlLoggerScreen extends StatelessWidget {
  const HswAdlLoggerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'hsw_adl_logger',
      title: 'HswAdlLoggerScreen',
      child: Column(
        children: const [
          const HswAdlLoggerHeaderSection(),
          const HswAdlLoggerFilterBarSection(),
          const HswAdlLoggerDataTableSection(),
          const HswAdlLoggerPaginationSection(),
          const HswAdlLoggerActionBarSection(),
        ],
      ),
    );
  }
}
