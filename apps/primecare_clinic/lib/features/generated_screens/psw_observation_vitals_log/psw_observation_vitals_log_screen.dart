import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'sections/psw_observation_vitals_log_header_section.dart';
import 'sections/psw_observation_vitals_log_filter_bar_section.dart';
import 'sections/psw_observation_vitals_log_data_table_section.dart';
import 'sections/psw_observation_vitals_log_pagination_section.dart';
import 'sections/psw_observation_vitals_log_action_bar_section.dart';

class PswObservationVitalsLogScreen extends StatelessWidget {
  const PswObservationVitalsLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenScaffold(
      screenCode: 'psw_observation_vitals_log',
      title: 'Psw Observation Vitals Log',
      child: Column(
        children: const [
          const PswObservationVitalsLogHeaderSection(),
          const PswObservationVitalsLogFilterBarSection(),
          const PswObservationVitalsLogDataTableSection(),
          const PswObservationVitalsLogPaginationSection(),
          const PswObservationVitalsLogActionBarSection(),
        ],
      ),
    );
  }
}
