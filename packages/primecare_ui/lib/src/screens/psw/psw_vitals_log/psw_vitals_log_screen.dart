import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_vitals_log_header_section.dart';
import 'sections/psw_vitals_log_filter_bar_section.dart';
import 'sections/psw_vitals_log_data_table_section.dart';
import 'sections/psw_vitals_log_pagination_section.dart';
import 'sections/psw_vitals_log_action_bar_section.dart';

class PswVitalsLogScreen extends StatelessWidget {
  const PswVitalsLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_vitals_log',
      title: 'Vitals Entry',
      child: Column(
        children: const [
          const PswVitalsLogHeaderSection(),
          const PswVitalsLogFilterBarSection(),
          const PswVitalsLogDataTableSection(),
          const PswVitalsLogPaginationSection(),
          const PswVitalsLogActionBarSection(),
        ],
      ),
    );
  }
}

typedef VitalsEntryScreen = PswVitalsLogScreen;
